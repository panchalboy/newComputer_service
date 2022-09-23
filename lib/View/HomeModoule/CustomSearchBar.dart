import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/DashboardController.dart';
import '../../shared_components/common_list_ui.dart';

class CustumSearchBar extends StatefulWidget {
  Function onTap;

  CustumSearchBar({Key key, this.onTap}) : super(key: key);

  @override
  State<CustumSearchBar> createState() => _CustumSearchBarState();
}

class _CustumSearchBarState extends State<CustumSearchBar> {
  TextEditingController SearchController = TextEditingController();
  DashboardController dashboardController = Get.find<DashboardController>();

  onSearch() async {
    dashboardController.onSearch(SearchController.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashboardController.serchProduct.clear();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.2;

    final double itemWidth = size.width / 2;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              color: Colors.red,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    Container(
                        width: Get.width * 0.70,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: SearchController,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: "Search Product",
                              hintStyle: TextStyle(color: Colors.grey)),
                        )),
                    TextButton(
                      onPressed: () {
                        onSearch();
                      },
                      child: Text(
                        "Go",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ]),
            ),
            Obx(() {
              return dashboardController.isSearchLoading
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: GridView.builder(
                            itemCount: dashboardController.serchProduct.length,
                            controller:
                                ScrollController(keepScrollOffset: false),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: (itemWidth / itemHeight),
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5.5,
                                    crossAxisSpacing: 5.5),
                            itemBuilder: (context, index) {
                              var item =
                                  dashboardController.serchProduct[index];
                              return CardListui(
                                image: item.productImg,
                                productName: item.productName,
                                shortDec: item.shortDesc,
                                fullDec: item.fullDesc,
                                delerPrice: item.mrp,
                                selesePrice: item.salePrice,
                                ontap: () => widget.onTap(item),
                              );
                            }),
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
