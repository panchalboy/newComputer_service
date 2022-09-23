import 'package:computer_service/Utils/nodatafound.dart';
import 'package:computer_service/shared_components/comonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // for date format

import '../../Controller/MyServicesController.dart';
import '../../shared_components/HeaderAppBar.dart';
import '../../shared_components/commom_bottom_sheet.dart';
import '../../shared_components/product_list.dart';

class MyServicePage extends StatefulWidget {
  const MyServicePage({Key key}) : super(key: key);

  @override
  State<MyServicePage> createState() => _MyServicePageState();
}

class _MyServicePageState extends State<MyServicePage> {
  MyServicsController myservicsController = Get.put(MyServicsController());

  onTap(item, expiceDate, deleryDate, orderDate) {
    showCommonBottomSheet(
        context: context,
        child: DraggableScrollableSheet(
            initialChildSize: 0.50,
            maxChildSize: 0.50,
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return Center(
                child: MyServiceDetails(
                  item: item,
                  expiceDate: expiceDate,
                  deleryDate: deleryDate,
                  orderDate: orderDate,
                ),
              );
            }),
        isDismissible: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppBar(
        appBar: AppBar(),
        title: 'My Services',
        rootContext: context,
        showDrawerButton: true,
      ),
      body: GetBuilder(
        init: myservicsController,
        builder: (controller) {
          return controller.isLoading
              ? commonLoader()
              : controller.allProduct.length == 0
                  ? NoDataFound()
                  : ListView.builder(
                      itemCount: controller.allProduct.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.allProduct[index];
                        print("item---$item");
                        var delevryDate;
                        var expireDate;
                        String deleryDate;
                        String expiceDate;
                        String orderDate;
                        if (item.sale.deliveryDate != null ||
                            item.expDate != null) {
                          delevryDate = item.sale.deliveryDate;
                          deleryDate = DateFormat("dd-MMM-yyyy")
                              .format(DateTime.parse(delevryDate));
                          expireDate = item.expDate;
                          expiceDate = DateFormat("dd-MMM-yyyy")
                              .format(DateTime.parse(expireDate));
                        } else {}
                        orderDate = DateFormat("dd-MMM-yyyy")
                            .format(DateTime.parse(item.createdAt));
                        print("orderDate----$orderDate");
                        return MyProductList(
                          image: 'assets/m2.jpg',
                          name: item.service.title,
                          price: item.servicePrice,
                          description: item.service.description,
                          orderDate: orderDate,
                          recivedDate: deleryDate,
                          onTap: () =>
                              onTap(item, expiceDate, deleryDate, orderDate),
                        );
                      });
        },
      ),
    );
  }
}

class MyServiceDetails extends StatefulWidget {
  var item;
  var expiceDate;
  var deleryDate;
  var orderDate;
  MyServiceDetails(
      {Key key, this.item, this.expiceDate, this.deleryDate, this.orderDate})
      : super(key: key);

  @override
  State<MyServiceDetails> createState() => _MyServiceDetailsState();
}

class _MyServiceDetailsState extends State<MyServiceDetails> {
  @override
  void initState() {
    // TODO: implement initState
    print("item---==------${widget.item}");
    super.initState();
  }

  Widget get defaultModalHeader {
    return AppBar(
      toolbarHeight: 40,
      elevation: 0,
      backgroundColor: Colors.white10,
      centerTitle: true,
      leadingWidth: 25,
      leading: CloseButton(),
      iconTheme: IconThemeData(
        color: Colors.black38,
      ),
      title: Text(
        "Service Details",
        style: TextStyle(
            color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          defaultModalHeader,
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Name :",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      widget.item.service.title,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Service Charge:",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "\u{20B9}${widget.item.service.serviceCharge}",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Text(
                        "Description:",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Text(
                        widget.item.service.description,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order Date:",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      widget.orderDate,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                widget.item.sale.status == 'delivered'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery Date:",
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            widget.deleryDate,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    : SizedBox(),
                widget.item.sale.gstNo != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "GST Number:",
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            widget.item.sale.gstNo.toString(),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    : SizedBox(),
                widget.item.serviceDiscount != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Service Discount:",
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            "\u{20B9}${widget.item.serviceDiscount}",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    : SizedBox(),
                SizedBox(
                  height: 5,
                ),
                widget.item.sale.status == 'delivered'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Expire Date:",
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            widget.expiceDate.toString(),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    : SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Status:",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      widget.item.sale.status.toUpperCase(),
                      style: TextStyle(
                          color: widget.item.sale.status == 'delivered'
                              ? Colors.green
                              : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Service Price:",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "\u{20B9}${widget.item.totalServicePrice}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
