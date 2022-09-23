import 'package:computer_service/Controller/MyProduct.dart';
import 'package:computer_service/Utils/nodatafound.dart';
import 'package:computer_service/shared_components/common_list_ui.dart';
import 'package:computer_service/shared_components/comonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // for date format

import '../../shared_components/HeaderAppBar.dart';
import '../../shared_components/commom_bottom_sheet.dart';
import '../../shared_components/product_list.dart';

class MyProductPage extends StatefulWidget {
  const MyProductPage({Key key}) : super(key: key);

  @override
  State<MyProductPage> createState() => _MyProductPageState();
}

class _MyProductPageState extends State<MyProductPage> {
  MyProductController myProductController = MyProductController();
  onTap(item, expiceDate, deleryDate, orderDate) {
    showCommonBottomSheet(
        context: context,
        child: DraggableScrollableSheet(
            initialChildSize: 0.50,
            maxChildSize: 0.50,
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return Center(
                child: MyProductDetails(
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
        title: 'My Product',
        rootContext: context,
        showDrawerButton: true,
      ),
      body: GetBuilder(
        init: myProductController,
        builder: (controller) {
          return controller.isLoading
              ? commonLoader()
              : controller.allProduct.length == 0
                  ? NoDataFound()
                  : ListView.builder(
                      itemCount: controller.allProduct.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.allProduct[index];
                        String expiceDate;
                        String deleryDate;
                        String orderDate;
                        final expireDate =
                            item.expDate == null ? "" : item.expDate;
                        if (item.expDate != null) {
                          expiceDate = DateFormat("dd-MMM-yyyy")
                              .format(DateTime.parse(expireDate));
                          final delevryDate = item.sale.deliveryDate;
                          deleryDate = DateFormat("dd-MMM-yyyy")
                              .format(DateTime.parse(delevryDate));
                        }
                        orderDate = DateFormat("dd-MMM-yyyy")
                            .format(DateTime.parse(item.createdAt));
                        print("orderDate----$orderDate");

                        print("item---$item");
                        return MyProductList(
                          image: item.product.productImg,
                          name: item.product.productName,
                          price: item.productPrice,
                          description: item.product.shortDesc,
                          recivedDate: item.sale.deliveryDate,
                          orderDate: orderDate,
                          onTap: () =>
                              onTap(item, expiceDate, deleryDate, orderDate),
                        );
                      });
        },
      ),
    );
  }
}

class MyProductDetails extends StatefulWidget {
  var item;
  var expiceDate;
  var deleryDate;
  var orderDate;
  MyProductDetails(
      {Key key, this.item, this.expiceDate, this.deleryDate, this.orderDate})
      : super(key: key);

  @override
  State<MyProductDetails> createState() => _MyProductDetailsState();
}

class _MyProductDetailsState extends State<MyProductDetails> {
  double qyt;
  int productQyt;
  @override
  void initState() {
    // TODO: implement initState
    print("item---==------${widget.item.productQty}");
    qyt = double.parse(widget.item.productQty);
    productQyt = qyt.round();

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
        "Product Details",
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
                      widget.item.product.productName,
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
                      "Price:",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "\u{20B9}${widget.item.productPrice}",
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
                        widget.item.product.shortDesc,
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
                      "Product Qty:",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      productQyt.toString(),
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
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
                      "Total Price:",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      widget.item.totalProductPrice,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
