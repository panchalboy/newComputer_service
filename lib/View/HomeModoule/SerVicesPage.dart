import 'package:computer_service/Controller/ServicesController.dart';
import 'package:computer_service/Utils/nodatafound.dart';
import 'package:computer_service/shared_components/common_list_ui.dart';
import 'package:computer_service/shared_components/comonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Routes/routes.dart';
import '../../shared_components/HeaderAppBar.dart';
import '../../shared_components/commom_bottom_sheet.dart';
import '../productdetails/product_details_page.dart';
import '../productdetails/service_details_page.dart';

class SerVicesPage extends StatefulWidget {
  const SerVicesPage({Key key}) : super(key: key);

  @override
  State<SerVicesPage> createState() => _SerVicesPageState();
}

class _SerVicesPageState extends State<SerVicesPage> {
  ServicsController servicsController = Get.put(ServicsController());

  onTap(item) {
    setState(() {
      Get.to(ServiceDetails(
        id: item.id,
        productName: item.title,
      ));
    });
  }

  // onTap(item) {
  //   showCommonBottomSheet(
  //       context: context,
  //       child: DraggableScrollableSheet(
  //           initialChildSize: 0.50,
  //           maxChildSize: 0.50,
  //           expand: false,
  //           builder: (BuildContext context, ScrollController scrollController) {
  //             return Center(
  //               child: ServiceDetails(
  //                 id: item.id,
  //               ),
  //             );
  //           }),
  //       isDismissible: true);
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.2;
    final double itemWidth = size.width / 2;
    return Scaffold(
        appBar: HeaderAppBar(
          appBar: AppBar(),
          title: 'Services',
          rootContext: context,
          showDrawerButton: true,
        ),
        body: GetBuilder(
          init: servicsController,
          builder: (controller) {
            return controller.isLoading
                ? commonLoader()
                : controller.allProduct.length == 0
                    ? NoDataFound()
                    : GridView.builder(
                        itemCount: controller.allProduct.length,
                        controller: ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (itemWidth / itemHeight),
                            crossAxisCount: 2,
                            mainAxisSpacing: 5.5,
                            crossAxisSpacing: 5.5),
                        itemBuilder: (context, index) {
                          final item = controller.allProduct[index];
                          return CardListui(
                            image: item.image,
                            productName: item.title,
                            shortDec: item.description,
                            fullDec: item.serviceCharge,
                            delerPrice: item.serviceCharge,
                            selesePrice: item.validity.validity,
                            validity: item.validity.validity,
                            ontap: () => onTap(item),
                          );
                        });
          },
        ));
  }
}

// class ServiceDetails extends StatefulWidget {
//   var id;
//   ServiceDetails({Key key, this.id}) : super(key: key);

//   @override
//   State<ServiceDetails> createState() => _ServiceDetailsState();
// }

// class _ServiceDetailsState extends State<ServiceDetails> {
//   ServicsController servicsController = Get.find<ServicsController>();

//   @override
//   void initState() {
//     // TODO: implement initState
//     servicsController.getService(widget.id);
//     super.initState();
//   }

//   Widget get defaultModalHeader {
//     return AppBar(
//       toolbarHeight: 40,
//       elevation: 0,
//       backgroundColor: Colors.white10,
//       centerTitle: true,
//       leadingWidth: 25,
//       leading: CloseButton(),
//       iconTheme: IconThemeData(
//         color: Colors.black38,
//       ),
//       title: Text(
//         "Service Details",
//         style: TextStyle(
//             color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//         init: servicsController,
//         builder: (controller) {
//           return controller.isSericeLodding
//               ? commonLoader()
//               : controller.serviceDetails == null
//                   ? Center(
//                       child: Text("NO DATA FOUND"),
//                     )
//                   : Container(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 10,
//                           ),
//                           defaultModalHeader,
//                           Divider(),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Title :",
//                                       style: TextStyle(fontSize: 15),
//                                     ),
//                                     Text(
//                                       controller.serviceDetails.service.title,
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Service Charge:",
//                                       style: TextStyle(fontSize: 15),
//                                     ),
//                                     Text(
//                                       "\u{20B9}${controller.serviceDetails.service.serviceCharge}",
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Flexible(
//                                       flex: 4,
//                                       child: Text(
//                                         "Description:",
//                                         style: TextStyle(fontSize: 15),
//                                       ),
//                                     ),
//                                     Flexible(
//                                       flex: 3,
//                                       child: Text(
//                                         controller
//                                             .serviceDetails.service.description,
//                                         style: TextStyle(
//                                             overflow: TextOverflow.ellipsis,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 controller.serviceDetails.sale.status ==
//                                         'delivered'
//                                     ? Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             "Delivery Date:",
//                                             style: TextStyle(fontSize: 15),
//                                           ),
//                                           Text(
//                                             controller.deliveryDateS,
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.bold),
//                                           )
//                                         ],
//                                       )
//                                     : SizedBox(),
//                                 controller.serviceDetails.sale.gstNo != null
//                                     ? Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             "GST Number:",
//                                             style: TextStyle(fontSize: 15),
//                                           ),
//                                           Text(
//                                             controller.serviceDetails.sale.gstNo
//                                                 .toString(),
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.bold),
//                                           )
//                                         ],
//                                       )
//                                     : SizedBox(),
//                                 controller.serviceDetails.serviceDiscount !=
//                                         null
//                                     ? Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             "Service Discount:",
//                                             style: TextStyle(fontSize: 15),
//                                           ),
//                                           Text(
//                                             "\u{20B9}${controller.serviceDetails.serviceDiscount}",
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.bold),
//                                           )
//                                         ],
//                                       )
//                                     : SizedBox(),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 controller.serviceDetails.sale.status ==
//                                         'delivered'
//                                     ? Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             "Expire Date:",
//                                             style: TextStyle(fontSize: 15),
//                                           ),
//                                           Text(
//                                             controller.expireDates,
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.bold),
//                                           )
//                                         ],
//                                       )
//                                     : SizedBox(),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Status:",
//                                       style: TextStyle(fontSize: 15),
//                                     ),
//                                     Text(
//                                       controller.serviceDetails.sale.status
//                                           .toUpperCase(),
//                                       style: TextStyle(
//                                           color: controller.serviceDetails.sale
//                                                       .status ==
//                                                   'delivered'
//                                               ? Colors.green
//                                               : Colors.red,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Divider(),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Total Service Price:",
//                                       style: TextStyle(fontSize: 15),
//                                     ),
//                                     Text(
//                                       "\u{20B9}${controller.serviceDetails.totalServicePrice}",
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//         });
//   }
// }
