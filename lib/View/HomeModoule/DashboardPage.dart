import 'package:computer_service/Routes/routes.dart';

import 'package:computer_service/Utils/nodatafound.dart';
import 'package:computer_service/View/HomeModoule/CustomSearchBar.dart';
import 'package:computer_service/View/productdetails/product_details_page.dart';
import 'package:computer_service/shared_components/HeaderAppBar.dart';
import 'package:computer_service/shared_components/common_list_ui.dart';
import 'package:computer_service/shared_components/comonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/DashboardController.dart';
import '../ProductSearch.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.2;
    final double itemWidth = size.width / 2;

    onTap(item) {
      setState(() {
        Get.to(ProductDetailScreen(
          id: item.id,
          productName: item.productName,
        ));
        // Get.toNamed(
        //   Routes.PRODUCT_DETAILS,
        //   arguments: {
        //     "id": item.id,
        //     "type": "PRODUCT",
        //     "ProductName": item.productName
        //   },
        // );
      });
    }

    return Scaffold(
        appBar: HeaderAppBar(
          appBar: AppBar(),
          title: 'Products',
          rootContext: context,
          showDrawerButton: true,
          actions: [
            IconButton(
                color: Colors.white,
                onPressed: () {
                  Get.to(CustumSearchBar(
                    onTap: dashboardController.onClick,
                  ));
                  // showSearch(
                  //     context: context,
                  //     delegate: SearchProduct(
                  //         onTap: dashboardController.onClick,
                  //         onSearch: dashboardController.onSearch));
                },
                icon: new Icon(
                  Icons.search,
                  color: Colors.red,
                )),
          ],
        ),
        body: GetBuilder(
          init: dashboardController,
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
                            image: item.productImg,
                            productName: item.productName,
                            shortDec: item.shortDesc,
                            fullDec: item.fullDesc,
                            delerPrice: item.mrp,
                            selesePrice: item.salePrice,
                            ontap: () => onTap(item),
                          );
                        });
          },
        ));
  }
}
