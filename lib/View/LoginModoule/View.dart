import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../Http/dioClient.dart';
import '../../Routes/routes.dart';
import '../../Utils/utils.dart';
import '../../Utils/velidation.dart';
import '../../auth/text_field_widget.dart';
import '../../shared_components/comonWidget.dart';
import '../../shared_components/loadding_button.dart';

DioClient dioClient = DioClient();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // LoginController loginController = Get.put(LoginController());
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool autovalidateMode = false;
  bool loading = false;
  bool _showPassword = true;
  Map<String, dynamic> form = {};
  onChange(String key, dynamic value) {
    form.update(key, (v) => value, ifAbsent: () => value);
  }

  onLogin() async {
    if (_loginFormKey.currentState.validate()) {
      _loginFormKey.currentState.save();
      loginApi();
    } else {
      setState(() {
        autovalidateMode = true;
      });
    }
  }

  loginApi() async {
    try {
      setState(() {
        loading = true;
      });
      var response = await dioClient.postRequest(
        'auth/login',
        {"email": form['email'], "password": form['password']},
      );
      final res = response.data;
      print("res----$res");
      setState(() {
        loading = false;
      });

      if (res['message'] == "Success") {
        toastWidget(res['message']);
        onLocalSetup(res['result']);
      }
    } catch (error) {
      print("error--$error");
      setState(() {
        loading = false;
      });
      toastWidget('Please login with valid credentials');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                    key: _loginFormKey,
                    autovalidateMode: autovalidateMode
                        ? AutovalidateMode.onUserInteraction
                        : null,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          labelText: 'Email',
                          requiredPadding: true,
                          onSaved: (v) =>
                              onChange('email', v.toString().trim()),
                          validator: (v) =>
                              AppFieldValidations.emailmobileFiledValidation(v),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          labelText: 'Password',
                          textInputType: TextInputType.visiblePassword,
                          requiredPadding: true,
                          onSaved: (v) =>
                              onChange('password', v.toString().trim()),
                          validator: (v) =>
                              AppFieldValidations.emptyText(v, 'password'),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(
                    Routes.FORGOT_PASSWORD,
                  );
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Forgot Password?")),
              ),
              LoadingButton(
                  title: "Login", onPressed: onLogin, loading: loading),
            ],
          ),
        ),
      ),
      // bottomSheet: BottomSheetButton(),
    );
  }

  // ignore: non_constant_identifier_names
  Widget TextWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("welcome",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25))),
          const SizedBox(
            height: 5,
          ),
          Text("Sign in Continue!",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ))
        ],
      ),
    );
  }

  Widget SubmitButtonWidget() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: MediaQuery.of(context).size.width,
        height: 45,
        // ignore: deprecated_member_use
        child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Colors.transparent)),
            onPressed: () {
              if (_loginFormKey.currentState.validate()) {
                //  loginController.fachLoginResponce();
                Get.toNamed(
                  Routes.HOME,
                );
              }
            },
            color: Colors.red,
            textColor: Colors.red,
            child:
                //  loginController.isLoading.value?
                // CircularProgressIndicator():
                const Text("login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold))),
      ),
    );
  }

  // ignore: non_c  onstant_identifier_names
  Widget BottomSheetButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 15),
      child: RichText(
        text: TextSpan(children: [
          const TextSpan(
              text: "I'm New User",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w300)),
          TextSpan(
              text: "SignUP",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 18,
                  decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(
                    Routes.SIGNP,
                  );
                }),
        ]),
      ),
    );
  }
}
