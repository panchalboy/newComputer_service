import 'package:computer_service/Http/dioClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Routes/routes.dart';
import '../Utils/velidation.dart';
import '../auth/text_field_widget.dart';
import '../shared_components/comonWidget.dart';
import '../shared_components/loadding_button.dart';
import 'get_all_support.dart';

DioClient dioClient = DioClient();

class CreateSupport extends StatefulWidget {
  const CreateSupport({Key key}) : super(key: key);

  @override
  State<CreateSupport> createState() => _CreateSupportState();
}

class _CreateSupportState extends State<CreateSupport> {
  final GlobalKey<FormState> _supportFormKey = GlobalKey<FormState>();
  bool autovalidateMode = false;
  bool loading = false;
  Map<String, dynamic> form = {};
  onChange(String key, dynamic value) {
    form.update(key, (v) => value, ifAbsent: () => value);
  }

  onSupport() async {
    if (_supportFormKey.currentState.validate()) {
      _supportFormKey.currentState.save();
      supportApi();
    } else {
      setState(() {
        autovalidateMode = true;
      });
    }
  }

  supportApi() async {
    try {
      setState(() {
        loading = true;
      });
      var response = await dioClient.postRequest(
        'support/create',
        {
          "subject": form['subject'],
          "full_description": form['full_description']
        },
      );
      final res = response.data;
      print("res----$res");
      setState(() {
        loading = false;
      });

      if (res['message'] == "Success") {
        toastWidget(res['message']);

        Get.off(() => GetAllSupport());

        // Get.toNamed(
        //   Routes.GET_ALL_SUPPORT,
        // );
      }
    } catch (error) {
      print("error--$error");
      setState(() {
        loading = false;
      });
      toastWidget('Something Went Wrong...');
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
                    key: _supportFormKey,
                    autovalidateMode: autovalidateMode
                        ? AutovalidateMode.onUserInteraction
                        : null,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          labelText: 'Subject',
                          requiredPadding: true,
                          onSaved: (v) =>
                              onChange('subject', v.toString().trim()),
                          validator: (v) =>
                              AppFieldValidations.emptyText(v, "subject"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          labelText: 'description',
                          maxLine: 3,
                          requiredPadding: true,
                          onSaved: (v) =>
                              onChange('full_description', v.toString().trim()),
                          validator: (v) => AppFieldValidations.emptyText(
                              v, 'full Description'),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              LoadingButton(
                  title: "Create Support",
                  onPressed: onSupport,
                  loading: loading),
            ],
          ),
        ),
      ),
    );
  }
}

Widget TextWidget() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Support",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25))),
        const SizedBox(
          height: 5,
        ),
        Text("Create Support!",
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
