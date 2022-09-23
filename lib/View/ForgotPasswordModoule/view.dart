import 'package:computer_service/Http/dioClient.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Routes/routes.dart';
import '../../Utils/velidation.dart';
import '../../auth/text_field_widget.dart';
import '../../shared_components/comonWidget.dart';
import '../../shared_components/loadding_button.dart';

DioClient dioClient = DioClient();

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  Map<String, dynamic> form = {};
  bool loading = false;
  final GlobalKey<FormState> _forgotFormKey = GlobalKey<FormState>();

  bool autovalidateMode = false;

  onChange(String key, dynamic value) {
    form.update(key, (v) => value, ifAbsent: () => value);
  }

  onForgotPassoword() async {
    if (_forgotFormKey.currentState.validate()) {
      _forgotFormKey.currentState.save();
      forgotApi();
    } else {
      setState(() {
        autovalidateMode = true;
      });
    }
  }

  forgotApi() async {
    try {
      setState(() {
        loading = true;
      });
      var response = await dioClient.postRequest(
        'auth/password/forgot',
        {
          "email": form['email'],
        },
      );
      final res = response.data;
      print("res----$res");
      setState(() {
        loading = false;
      });

      if (res['message'] == "Success") {
        toastWidget(res['message']);
        Get.offAllNamed(Routes.LOGIN);
      } else if (res['error'] == true) {
        toastWidget(res['message']);
      }
    } catch (error) {
      print("error--$error");
      setState(() {
        loading = false;
      });
      toastWidget('Something Went Wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(0),
                    alignment: Alignment.center,
                    child: IconButton(
                      // ignore: prefer_const_constructors
                      icon: Icon(Icons.arrow_back_ios),
                      iconSize: 30,
                      color: Colors.black,

                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
              TextWidget(),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _forgotFormKey,
                  autovalidateMode: autovalidateMode
                      ? AutovalidateMode.onUserInteraction
                      : null,
                  child: TextFieldWidget(
                    labelText: 'Email',
                    requiredPadding: true,
                    onSaved: (v) => onChange('email', v.toString().trim()),
                    validator: (v) =>
                        AppFieldValidations.emailmobileFiledValidation(v),
                  ),
                ),
              ),
              LoadingButton(
                  title: "Send Email",
                  onPressed: onForgotPassoword,
                  loading: loading),
            ],
          ),
        ),
      ),
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
          Text("Forgot Password!",
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

  // ignore: non_constant_identifier_names
  // ignore: non_constant_identifier_names

}
