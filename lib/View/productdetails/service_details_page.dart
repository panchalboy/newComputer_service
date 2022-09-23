import 'package:computer_service/Controller/MyServicesController.dart';
import 'package:computer_service/Controller/ServiceDetailsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../shared_components/comonWidget.dart';

class ServiceDetails extends StatefulWidget {
  var id;
  var productName;
  ServiceDetails({Key key, this.id, this.productName}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  bool isLodding = false;
  int productQyt = 1;
  SerivceDetailsController controller = Get.put(SerivceDetailsController());
  MyServicsController myServicsController = Get.put(MyServicsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getServiceDetails(widget.id);
  }

  void createOrder(context, id, qyt) async {
    try {
      setState(() {
        isLodding = true;
      });

      // changeOrderLoading(true);
      final url = "order/service/create";

      final reqObj = {
        "service_id": id,
        "qty": qyt,
      };
      print("url---$url----$reqObj");
      final response = await controller.createOrder(url, reqObj);
      openAlertBox();
      setState(() {
        isLodding = false;
      });
      if (response.data['message'] == 'Success') {
        myServicsController.loadData();
      }

      print("resest---$reqObj-----${response.data['message']}");

      print("rest----${response.data['error']}");
    } catch (err) {
      setState(() {
        isLodding = false;
      });
      toastWidget("Something went wrong");
      print("error--$err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (contoller) {
        final item = contoller.serviceDetails;

        return Scaffold(
            bottomSheet: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLodding == true
                    ? commonLoader()
                    : ElevatedButton(
                        onPressed: () {
                          // openAlertBox();
                          createOrder(
                            context,
                            widget.id,
                            productQyt,
                          );
                        },
                        child: Text("Place Order"),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red[500],
                          elevation: 5.0,
                        ),
                      ),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                item == null ? "" : item.title.toString(),
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
              foregroundColor: Colors.red[500],
            ),
            body: contoller.isLoading
                ? commonLoader()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                  child: Image.network(
                                item.image,
                                fit: BoxFit.fitHeight,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return Image.asset('assets/m1.jpg');
                                },
                              )),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: CommonText(item.title),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo[900],
                                      border: Border.all(
                                        color: Colors.indigo[900],
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          productQyt == 1
                                              ? toastWidget(
                                                  "This is Minimum Quantity")
                                              : setState(() {
                                                  productQyt--;
                                                });
                                        },
                                        child: new Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      new Text(
                                        "${productQyt}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            productQyt++;
                                          });
                                        },
                                        child: new Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("\u{20B9}${item.mrp}",
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationThickness: 4,
                                          color: Colors.green[500],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 8),
                                    child: Text(
                                        "Warranty: ${controller.serviceDetails.validity.months.toString()} months",
                                        style: TextStyle(
                                            color: Colors.green[500],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ],
                              ),
                            ),
                            CommonText(" \u{20B9} ${item.serviceCharge}"),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Html(
                                    data: item.fullDesc == null
                                        ? ""
                                        : item.fullDesc)

                                // Html(data: item.fullDesc),
                                ),
                            SizedBox(
                              height: 15,
                            ),
                            CommonText("Relevant Services"),
                            Container(
                              height: 350,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: contoller
                                      .serviceDetails.relevantServices.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final relevantSerives = contoller
                                        .serviceDetails.relevantServices[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ServiceDetails(
                                                    id: relevantSerives.id,
                                                    productName: item.title,
                                                  )),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: Get.width / 1.8,
                                          child: Card(
                                            elevation: 2.0,
                                            margin: const EdgeInsets.all(0.0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.0)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 228,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                    child: Image.network(
                                                      relevantSerives.image,
                                                      errorBuilder:
                                                          (BuildContext context,
                                                              Object exception,
                                                              StackTrace
                                                                  stackTrace) {
                                                        return Image.asset(
                                                            'assets/m1.jpg');
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0),
                                                  child: Text(
                                                    relevantSerives.title,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color:
                                                            Colors.indigo[900],
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0),
                                                  child: Text(
                                                    relevantSerives.description,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0,
                                                          right: 10,
                                                          left: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "\u{20B9}${relevantSerives.mrp}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: Colors
                                                                .green[500],
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "\u{20B9}${relevantSerives.serviceCharge}",
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ]),
                    ),
                  ));
      },
    );
  }

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 500.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Place Order",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Container(
                    height: 100,
                    child: Center(
                      child: Text("Order has been placed successfully"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.red[500],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  CommonText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: Colors.indigo[900],
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
