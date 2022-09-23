import 'package:computer_service/Controller/getCitys.dart';
import 'package:computer_service/Http/dioClient.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../ModelClass/GetCitysModel.dart';
import '../../Utils/MyString.dart';
import '../../Utils/utils.dart';
import '../../Utils/velidation.dart';
import '../../auth/text_field_widget.dart';
import '../../shared_components/comonWidget.dart';
import '../../shared_components/loadding_button.dart';
import '../LoginModoule/View.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //  SignUpController signUpController=Get.put(SignUpController());
  GlobalKey<FormState> _SignUpFormKey = GlobalKey<FormState>();
  CityListController cityListController = Get.put(CityListController());
  Result currentSelectedCityValue;
  DioClient dio = DioClient();

  bool autovalidateMode = false;
  bool loading = false;

  Map<String, dynamic> form = {};
  onChange(String key, dynamic value) {
    form.update(key, (v) => value, ifAbsent: () => value);
  }

  @override
  void initState() {
    // cityListController.loadData();
    super.initState();
  }

  onSignUp() async {
    if (_SignUpFormKey.currentState.validate()) {
      _SignUpFormKey.currentState.save();
      if (currentSelectedCityValue == null) {
        toastWidget("Please Select City");
      } else {
        signUpApi();
      }
    } else {
      setState(() {
        autovalidateMode = true;
      });
    }
  }

  signUpApi() async {
    try {
      final reqestObj = {
        "email": form['email'],
        "password": form['password'],
        "name": form["name"],
        "mobile_no": form['phone'],
        "city_id": currentSelectedCityValue.id,
        "address": form["address"]
      };
      setState(() {
        loading = true;
      });
      var response = await dio.postRequest('auth/register', reqestObj);
      final res = response.data;
      print("res----$res");
      toastWidget(res['message']);
      onLocalSetup(res['result']);
      setState(() {
        loading = false;
      });

      if (res['message'] == "Success") {
        toastWidget(res['message']);
        onLocalSetup(res['result']);
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                    key: _SignUpFormKey,
                    autovalidateMode: autovalidateMode
                        ? AutovalidateMode.onUserInteraction
                        : null,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          labelText: 'Name',
                          requiredPadding: true,
                          onSaved: (v) => onChange('name', v.toString().trim()),
                          validator: (v) =>
                              AppFieldValidations.emptyText(v, "Name"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
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
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          labelText: 'Password',
                          textInputType: TextInputType.visiblePassword,
                          requiredPadding: true,
                          onSaved: (v) =>
                              onChange('password', v.toString().trim()),
                          validator: (v) =>
                              AppFieldValidations.emptyText(v, 'password'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          textInputType: TextInputType.phone,
                          maxLength: 10,
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                          labelText: 'Mobile Number',
                          requiredPadding: true,
                          onSaved: (v) =>
                              onChange('phone', v.toString().trim()),
                          validator: (v) =>
                              AppFieldValidations.phoneValidation(v),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          padding: EdgeInsets.symmetric(horizontal: 05),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Result>(
                              hint: Text('Select city'),
                              value: currentSelectedCityValue,
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  currentSelectedCityValue = newValue;

                                  onChange(
                                      'city_id', currentSelectedCityValue.id);
                                });
                              },
                              items: cityListController.allcity
                                  .map((dynamic value) {
                                return DropdownMenuItem<Result>(
                                  value: value,
                                  child: Text(value.cityName),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          prefixIcon: const Icon(
                            Icons.location_city_sharp,
                            color: Colors.grey,
                          ),
                          labelText: 'Address',
                          requiredPadding: true,
                          onSaved: (v) =>
                              onChange('address', v.toString().trim()),
                          validator: (v) =>
                              AppFieldValidations.emptyText(v, "address"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ),
              LoadingButton(
                  title: "Register", onPressed: onSignUp, loading: loading),
            ],
          ),
        ),
      ),
      bottomSheet: BottomSheetButton(),
    );
  }

  Widget TextWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            MyString.createAccount,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            MyString.signUptitle,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
          )
        ],
      ),
    );
  }

  // Widget TextFieldWidget() {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
  //     child: Column(
  //       children: [
  //         Container(
  //           child: Form(
  //               // autovalidate: true,
  //               key: _SignUpFormKey,
  //               child: Column(
  //                 children: [
  //                   TextFormField(
  //                     textInputAction: TextInputAction.next,
  //                     // controller: signUpController.name,
  //                     style: const TextStyle(fontSize: 18, color: Colors.grey),
  //                     validator: MultiValidator([
  //                       RequiredValidator(errorText: "Name Required!"),
  //                       // EmailValidator(
  //                       //     errorText: "Enter Valid Email!")
  //                     ]),
  //                     keyboardType: TextInputType.text,
  //                     autofocus: false,
  //                     // initialValue: 'alucard@gmail.com',
  //                     decoration: InputDecoration(
  //                       labelText: 'Full Name',
  //                       labelStyle:
  //                           const TextStyle(fontSize: 16.0, color: Colors.grey),
  //                       errorBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         borderSide: BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       focusedErrorBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         borderSide: BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       focusedBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         borderSide: BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       enabledBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         borderSide: BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       errorStyle: const TextStyle(color: Colors.grey),
  //                       border: new OutlineInputBorder(
  //                         borderRadius:
  //                             const BorderRadius.all(Radius.circular(15)),
  //                         borderSide: BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       // hintText: 'User ID',
  //                       // hintStyle: TextStyle(
  //                       //     fontSize: 16.0, color: Colors.white60),
  //                       contentPadding:
  //                           const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
  //                       // border: InputBorder.none,
  //                       prefixIcon: const Icon(
  //                         Icons.person,
  //                         color: Colors.grey,
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 10),
  //                   TextFormField(
  //                     textInputAction: TextInputAction.next,
  //                     // controller: signUpController.email,
  //                     style: const TextStyle(fontSize: 18, color: Colors.grey),
  //                     validator: MultiValidator([
  //                       EmailValidator(errorText: 'Please valid Email'),
  //                       RequiredValidator(errorText: "Email Required!"),
  //                       EmailValidator(errorText: "Enter Valid Email!")
  //                     ]),
  //                     keyboardType: TextInputType.emailAddress,
  //                     autofocus: false,
  //                     // initialValue: 'alucard@gmail.com',
  //                     decoration: InputDecoration(
  //                       labelText: 'Email',
  //                       labelStyle:
  //                           const TextStyle(fontSize: 16.0, color: Colors.grey),
  //                       errorBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         borderSide: BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       focusedErrorBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         borderSide: BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       focusedBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         borderSide:
  //                             const BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       enabledBorder: const OutlineInputBorder(
  //                         borderRadius:
  //                             const BorderRadius.all(const Radius.circular(15)),
  //                         borderSide:
  //                             const BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       errorStyle: const TextStyle(color: Colors.grey),
  //                       border: new OutlineInputBorder(
  //                         borderRadius:
  //                             const BorderRadius.all(const Radius.circular(15)),
  //                         borderSide:
  //                             const BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       // hintText: 'User ID',
  //                       // hintStyle: TextStyle(
  //                       //     fontSize: 16.0, color: Colors.white60),
  //                       contentPadding:
  //                           const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
  //                       // border: InputBorder.none,
  //                       prefixIcon: const Icon(
  //                         Icons.email_outlined,
  //                         color: Colors.grey,
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 10),
  //                   TextFormField(
  //                     textInputAction: TextInputAction.next,
  //                     // controller: signUpController.contact,
  //                     style: const TextStyle(fontSize: 18, color: Colors.grey),
  //                     validator: MultiValidator([
  //                       RequiredValidator(errorText: "Phone Required!"),
  //                       // EmailValidator(
  //                       //     errorText: "Enter Valid Email!")
  //                     ]),
  //                     keyboardType: TextInputType.phone,
  //                     autofocus: false,
  //                     maxLength: 10,
  //                     // initialValue: 'alucard@gmail.com',
  //                     decoration: InputDecoration(
  //                       counterText: "",
  //                       labelText: 'Phone Number',
  //                       labelStyle:
  //                           const TextStyle(fontSize: 16.0, color: Colors.grey),
  //                       errorBorder: const OutlineInputBorder(
  //                         borderRadius:
  //                             BorderRadius.all(const Radius.circular(15)),
  //                         borderSide: BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       focusedErrorBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         borderSide: BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       focusedBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         borderSide: BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       enabledBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         borderSide: BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       errorStyle: const TextStyle(color: Colors.grey),
  //                       border: new OutlineInputBorder(
  //                         borderRadius:
  //                             const BorderRadius.all(const Radius.circular(15)),
  //                         borderSide:
  //                             const BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       // hintText: 'User ID',
  //                       // hintStyle: TextStyle(
  //                       //     fontSize: 16.0, color: Colors.white60),
  //                       contentPadding:
  //                           const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
  //                       // border: InputBorder.none,
  //                       prefixIcon: const Icon(
  //                         Icons.phone,
  //                         color: Colors.grey,
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 10),
  //                   TextFormField(
  //                     textInputAction: TextInputAction.next,
  //                     // controller: signUpController.password,
  //                     validator: MultiValidator(
  //                         [RequiredValidator(errorText: "Password Required!")]),
  //                     autofocus: false,
  //                     style: const TextStyle(fontSize: 18, color: Colors.grey),
  //                     // initialValue: 'some password',
  //                     obscureText: this._showPassword,
  //                     decoration: InputDecoration(
  //                       labelText: 'Password',
  //                       labelStyle:
  //                           const TextStyle(fontSize: 16.0, color: Colors.grey),
  //                       errorBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         borderSide:
  //                             const BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       focusedErrorBorder: const OutlineInputBorder(
  //                         borderRadius:
  //                             const BorderRadius.all(const Radius.circular(15)),
  //                         borderSide:
  //                             const BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       focusedBorder: const OutlineInputBorder(
  //                         borderRadius:
  //                             const BorderRadius.all(Radius.circular(15)),
  //                         borderSide:
  //                             const BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       enabledBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         borderSide: BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       errorStyle: const TextStyle(color: Colors.grey),
  //                       border: new OutlineInputBorder(
  //                         borderRadius:
  //                             const BorderRadius.all(const Radius.circular(15)),
  //                         borderSide:
  //                             const BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       contentPadding:
  //                           const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
  //                       prefixIcon: const Icon(
  //                         Icons.lock,
  //                         color: Colors.grey,
  //                       ),
  //                       suffixIcon: IconButton(
  //                         icon: Icon(
  //                           this._showPassword
  //                               ? Icons.visibility_off
  //                               : Icons.visibility,
  //                           color: this._showPassword
  //                               ? Colors.black87
  //                               : Colors.grey,
  //                         ),
  //                         onPressed: () {
  //                           setState(
  //                               () => this._showPassword = !this._showPassword);
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 10),
  //                   TextFormField(
  //                     textInputAction: TextInputAction.next,
  //                     controller: _ConformpasswordController,
  //                     validator: (value) {
  //                       // if (signUpController.password!.text.isEmpty) {
  //                       //   return 'Please re-enter password';
  //                       // }
  //                       // if (signUpController.password!.text != _ConformpasswordController.text) {
  //                       //   return "Password does not match";
  //                       // }
  //                       return null;
  //                     },
  //                     autofocus: false,
  //                     style: const TextStyle(fontSize: 18, color: Colors.grey),
  //                     // initialValue: 'some password',
  //                     obscureText: this._confirmPassword,
  //                     decoration: InputDecoration(
  //                       labelText: 'Confirm Password',
  //                       labelStyle:
  //                           const TextStyle(fontSize: 16.0, color: Colors.grey),
  //                       errorBorder: const OutlineInputBorder(
  //                         borderRadius:
  //                             const BorderRadius.all(const Radius.circular(15)),
  //                         borderSide:
  //                             const BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       focusedErrorBorder: const OutlineInputBorder(
  //                         borderRadius:
  //                             const BorderRadius.all(const Radius.circular(15)),
  //                         borderSide:
  //                             const BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       focusedBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         borderSide: BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       enabledBorder: const OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         borderSide: BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       errorStyle: const TextStyle(color: Colors.grey),
  //                       border: new OutlineInputBorder(
  //                         borderRadius:
  //                             const BorderRadius.all(const Radius.circular(15)),
  //                         borderSide:
  //                             const BorderSide(width: 1, color: Colors.grey),
  //                       ),
  //                       contentPadding:
  //                           const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
  //                       prefixIcon: const Icon(
  //                         Icons.lock,
  //                         color: Colors.grey,
  //                       ),
  //                       suffixIcon: IconButton(
  //                         icon: Icon(
  //                           _confirmPassword
  //                               ? Icons.visibility_off
  //                               : Icons.visibility,
  //                           color:
  //                               _confirmPassword ? Colors.black87 : Colors.grey,
  //                         ),
  //                         onPressed: () {
  //                           setState(
  //                               () => _confirmPassword = !_confirmPassword);
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               )),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget SubmitButtonWidget() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        width: MediaQuery.of(context).size.width,
        height: 45,
        // ignore: deprecated_member_use
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.transparent)),
          onPressed: () {
            if (_SignUpFormKey.currentState.validate()) {
              // signUpController.fatchSignUpResponce();

            }
          },
          color: Colors.red,
          textColor: Colors.red,
          child:
              //  signUpController.isLoading.value?
              //  const CircularProgressIndicator():
              Text(MyString.signUp,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget BottomSheetButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
      child: Container(
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: MyString.signUpButtomText,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300)),
            TextSpan(
                text: MyString.login,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 18,
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.to(LoginScreen());
                  }),
          ]),
        ),
      ),
    );
  }
}
