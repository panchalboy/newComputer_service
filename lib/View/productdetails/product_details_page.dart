import 'package:computer_service/Controller/ProctDetailsController.dart';
import 'package:computer_service/shared_components/comonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html_view/flutter_html_view.dart';
//import 'package:flutter_markdown/flutter_markdown.dart';

class ProductDetailScreen extends StatefulWidget {
  var id;
  var type;
  var productName;
  ProductDetailScreen({Key key, this.id, this.type, this.productName})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // String type = "";
  // var id;
  bool isLodding = false;
  int currentPos = 0;
  List img = [];
  CarouselController buttonCarouselController = CarouselController();
  String role;
  Map<String, dynamic> arguments = Get.arguments;
  ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());

  @override
  void initState() {
    // TODO: implement initState

    // id = arguments["id"];
    // type = arguments["type"];
    getStorage();
    getData();

    //  productImage.forEach((element) { })
    super.initState();
  }

  getData() {
    productDetailsController.loadData(widget.id);
  }

  getStorage() async {
    await GetStorage.init();
    final storage = GetStorage();
    role = storage.read("role");
  }

  void createOrder(context, id, qyt) async {
    try {
      setState(() {
        isLodding = true;
      });

      String key = "";
      // changeOrderLoading(true);
      final url = "order/product/create";

      final reqObj = {
        "product_id": id,
        "qty": qyt,
      };
      print("url---$url----$reqObj");
      final response = await dioClient.postRequest(url, reqObj);
      openAlertBox();
      setState(() {
        isLodding = false;
      });

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
//here goes the function

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: productDetailsController,
        builder: (contoller) {
          var item = contoller.productDetails.value.result;
          img = contoller.productImage;
          return Scaffold(
              bottomSheet: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLodding == true
                      ? commonLoader()
                      : ElevatedButton(
                          onPressed: () {
                            //openAlertBox();
                            createOrder(
                              context,
                              widget.id,
                              productDetailsController.productQyt,
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
                  item == null ? "" : item.productName.toString(),
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                ),
                foregroundColor: Colors.red[500],
              ),
              body: contoller.isLoading
                  ? commonLoader()
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselSlider(
                            options:
                                CarouselOptions(reverse: false, height: 400.0),
                            items: img.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ClipRRect(
                                        child: Image.network(
                                      i,
                                      fit: BoxFit.contain,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace stackTrace) {
                                        return Image.asset('assets/m1.jpg');
                                      },
                                    )),
                                  );
                                },
                              );
                            }).toList(),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CommonText(item.productName),
                                ),
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
                                        contoller.productQyt ==
                                                contoller.productDetails.value
                                                    .result.minQty
                                            ? toastWidget(
                                                "This is Minimum Quantity")
                                            : setState(() {
                                                contoller.productQyt--;
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
                                      "${contoller.productQyt}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          contoller.productQyt++;
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Text("\u{20B9}${item.salePrice}",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 4,
                                    color: Colors.green[500],
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)),
                          ),
                          CommonText(
                              "\u{20B9}${role == "dealer" ? item.dealerPrice : item.mrp}"),
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Html(data: item.fullDesc)

                              // Html(data: item.fullDesc),
                              ),

                          // CommonText("Product Gallery"),
                          // Container(
                          //   margin: EdgeInsets.all(10),
                          //   height: 120,
                          //   child: ListView.builder(
                          //       scrollDirection: Axis.horizontal,
                          //       itemCount: contoller.productDetails.value.result
                          //           .productGallery.length,
                          //       shrinkWrap: true,
                          //       itemBuilder: (context, index) {
                          //         final productGallery = contoller.productDetails
                          //             .value.result.productGallery[index];
                          //         return Container(
                          //           margin: EdgeInsets.only(right: 10),
                          //           child: Container(
                          //               child: ClipRRect(
                          //                 borderRadius: BorderRadius.all(
                          //                     Radius.circular(10.0)),
                          //                 child: Image.network(
                          //                   productGallery.img,
                          //                   fit: BoxFit.fitHeight,
                          //                   errorBuilder: (BuildContext context,
                          //                       Object exception,
                          //                       StackTrace stackTrace) {
                          //                     return Image.asset('assets/m1.jpg');
                          //                   },
                          //                 ),
                          //               ),
                          //               decoration: BoxDecoration(
                          //                   shape: BoxShape.rectangle,
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(10.0)),
                          //                   color: Colors.white,
                          //                   boxShadow: [
                          //                     BoxShadow(
                          //                       color:
                          //                           Colors.grey.withOpacity(0.4),
                          //                       spreadRadius: 0.5,
                          //                       blurRadius: 1,
                          //                     ),
                          //                   ]
                          //                   // border: Border.all(width: 1, color: widget.borderColor)
                          //                   )),
                          //         );
                          //       }),
                          // ),
                          SizedBox(
                            height: 15,
                          ),
                          CommonText("Relevant Products"),
                          Container(
                            height: 350,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: contoller.productDetails.value.result
                                    .relevantProducts.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final relevantProducts = contoller
                                      .productDetails
                                      .value
                                      .result
                                      .relevantProducts[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ProductDetailScreen(
                                                  id: relevantProducts.id,
                                                  type: "PRODUCT",
                                                  productName: item.productName,
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
                                                  BorderRadius.circular(16.0)),
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
                                                    relevantProducts.productImg,
                                                    errorBuilder: (BuildContext
                                                            context,
                                                        Object exception,
                                                        StackTrace stackTrace) {
                                                      return Image.asset(
                                                          'assets/m1.jpg');
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: Text(
                                                  relevantProducts.productName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.indigo[900],
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: Text(
                                                  relevantProducts.shortDesc,
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
                                                padding: const EdgeInsets.only(
                                                    top: 10.0,
                                                    right: 10,
                                                    left: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "\u{20B9}${relevantProducts.dealerPrice}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color:
                                                              Colors.green[500],
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "\u{20B9}${relevantProducts.salePrice}",
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                        ],
                      ),
                    ));
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
                      child: Text("Product has been placed successfully"),
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

  // void alerBox() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Order Placed"),
  //         content: Container(
  //             decoration: new BoxDecoration(
  //               shape: BoxShape.rectangle,
  //               color: const Color(0xFFFFFF),
  //               borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
  //             ),
  //             child: Text("Product has been placed successfully")),
  //         actions: [
  //           TextButton(
  //               style: ButtonStyle(),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 // onTap(true);
  //               },
  //               child: Text("Ok"))
  //         ],
  //       );
  //     },
  //   );
  // }

}

class CrouselImage extends StatefulWidget {
  const CrouselImage({Key key}) : super(key: key);

  @override
  State<CrouselImage> createState() => _CrouselImageState();
}

class _CrouselImageState extends State<CrouselImage> {
  final List<String> imgList = [
    'assets/m1.jpg',
    'assets/m2.jpg',
    'assets/m3.png',
    'assets/m1.jpg',
    'assets/m4.jpg',
    'assets/m1.jpg',
    'assets/m2.jpg',
  ];

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: CarouselSlider.builder(
            options: CarouselOptions(
                height: 400,
                viewportFraction: 1,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index)),
            itemCount: imgList.length,
            itemBuilder: (context, index, realIndex) {
              final sliderimage = imgList[index];
              return builImage(sliderimage, index);
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(16.0),
          child: buildIndicator(),
        ),
      ],
    );
  }

  Widget builImage(String sliderimage, int index) => Container(
          child: Image(
        image: AssetImage(sliderimage),
        fit: BoxFit.cover,
      ));

  buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imgList.length,
        effect: JumpingDotEffect(
          jumpScale: 2.0,
          spacing: 15.0,
          dotWidth: 11,
          dotHeight: 11,
          activeDotColor: Colors.red[500],
          dotColor: Colors.black12,
        ),
      );
}
