import 'package:computer_service/Controller/getCitys.dart';
import 'package:computer_service/Http/dioClient.dart';
import 'package:computer_service/Utils/utils.dart';
import 'package:computer_service/shared_components/CommonTextField.dart';
import 'package:computer_service/shared_components/HeaderAppBar.dart';
import 'package:computer_service/shared_components/comonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_select/smart_select.dart';

import '../../ModelClass/GetCitysModel.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  CityListController cityListController = Get.put(CityListController());
  final _formKey = GlobalKey<FormState>();
  DioClient dio = DioClient();
  bool loading = false;
  var customerId;
  bool submitloading = false;
  Map<String, dynamic> form = {};
  Map data;
  @override
  void initState() {
    getData();
    // cityListController.loadData("");
    super.initState();
  }

  getData() async {
    try {
      setState(() {
        loading = true;
      });
      final response = await dio.getRequest('/profile');
      data = response.data['result'];
      var cityId;
      print("data--$data");

      setState(() {
        cityId = data['customer']['city_id'];
        loading = false;
        customerId = data['customer']['id'];
      });
      await cityListController.loadData(cityId, form);

      print("city---id---$cityId");
    } catch (e) {
      print("Error Profile  ${e}");
      toastWidget("Something went wrong!!");
    }
  }

  onChange(key, value) {
    form.update(key, (v) => value, ifAbsent: () => value);
  }

  submit() async {
    print("form---$form");

    try {
      setState(() {
        submitloading = true;
      });
      final response = await dio.postRequest('/profile/update', form);
      toastWidget(response.data['message']);

      setState(() {
        submitloading = false;
      });
    } catch (e) {
      print("Error Profile  ${e}");
      toastWidget("Something went wrong!!");
    }
  }

  logout() async {
    commonAlertDialog(
        context, "Logout", "Are you sure you want to logout ?", "No", "Yes",
        onTap: (value) async {
      if (value) {
        onClearLocalSetup();
      } else {
        //Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppBar(
        appBar: AppBar(),
        title: 'Profile',
        rootContext: context,
        showDrawerButton: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: logout,
          ),
        ],
      ),
      body: loading == true
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.red[500],
                    child: Text(customerId.toString()),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Text(
                      "Customer ID: $customerId",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: FormField(),
                  ),
                ],
              ),
            ),
    );
  }

  FormField() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Name",
              style: TextStyle(color: Colors.red[500]),
            ),
          ),
          CommonTextField(
            labelText: "Enter Name",
            readonly: false,
            initialValue: data['name'] ?? "",
            onChange: (v) {
              onChange('name', v);
            },
            onSaved: (v) {
              onChange('name', v);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Email",
              style: TextStyle(color: Colors.red[500]),
            ),
          ),
          CommonTextField(
            labelText: "Enter Email",
            readonly: false,
            initialValue: data['email'] ?? "",
            onChange: (v) {
              onChange('email', v);
            },
            onSaved: (v) {
              onChange('email', v);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Mobile no.",
              style: TextStyle(color: Colors.red[500]),
            ),
          ),
          CommonTextField(
            labelText: "Enter mobile no.",
            readonly: false,
            initialValue: data['customer']['mobile_no'].toString() ?? "",
            onChange: (v) {
              onChange('mobile_no', v);
            },
            onSaved: (v) {
              onChange('mobile_no', v);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "City",
              style: TextStyle(color: Colors.red[500]),
            ),
          ),
          Obx(() {
            return cityListController.isCityLoading
                ? Container(
                    height: 20,
                    width: 20,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    padding: EdgeInsets.symmetric(horizontal: 05),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Result>(
                        hint: Text('Select city'),
                        value: cityListController.currentSelectedCityValue,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            cityListController.currentSelectedCityValue =
                                newValue;
                            onChange('city_id',
                                cityListController.currentSelectedCityValue.id);
                          });
                        },
                        items: cityListController.allcity.map((dynamic value) {
                          return DropdownMenuItem<Result>(
                            value: value,
                            child: Text(value.cityName),
                          );
                        }).toList(),
                      ),
                    ),
                  );
          }),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Address",
              style: TextStyle(color: Colors.red[500]),
            ),
          ),
          CommonTextField(
            labelText: "Enter Address",
            readonly: false,
            initialValue: data['customer']['address'].toString() ?? "",
            onChange: (v) {
              onChange('address', v);
            },
            onSaved: (v) {
              onChange('address', v);
            },
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     "Password",
          //     style: TextStyle(color: Colors.red[500]),
          //   ),
          // ),
          // CommonTextField(
          //   labelText: "Enter password",
          //   readonly: false,
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     "Confirm password",
          //     style: TextStyle(color: Colors.red[500]),
          //   ),
          // ),
          // CommonTextField(
          //   labelText: "Enter confirm password",
          //   readonly: false,
          // ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SubmitButtonWidget(),
          ),
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
            onPressed: submitloading == true
                ? null
                : () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      if (cityListController.currentSelectedCityValue != null) {
                        setState(() {
                          form['city_id'] =
                              cityListController.currentSelectedCityValue.id;
                          // form = {
                          //   'city_id':
                          //       cityListController.currentSelectedCityValue.id
                          // };
                        });
                        submit();
                      } else {
                        toastWidget("Please Seleted City");
                      }
                    }
                  },
            color: Colors.red,
            textColor: Colors.red,
            child: submitloading == true
                ? Transform.scale(
                    scale: 0.5,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ))
                :
                //  loginController.isLoading.value?
                // CircularProgressIndicator():
                const Text("Update",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold))),
      ),
    );
  }
}
