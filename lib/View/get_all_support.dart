import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../Controller/get_all_support.dart';
import '../Utils/nodatafound.dart';
import '../shared_components/comonWidget.dart';
import '../shared_components/product_list.dart';

class GetAllSupport extends StatefulWidget {
  const GetAllSupport({Key key}) : super(key: key);

  @override
  State<GetAllSupport> createState() => _GetAllSupportState();
}

class _GetAllSupportState extends State<GetAllSupport> {
  AllSupportController getSupprortController = Get.put(AllSupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("All Support"),
        foregroundColor: Colors.red[500],
      ),
      body: GetBuilder(
        init: getSupprortController,
        builder: (controller) {
          return controller.isLoading
              ? commonLoader()
              : controller.allProduct.length == 0
                  ? NoDataFound()
                  : ListView.builder(
                      itemCount: controller.allProduct.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.allProduct[index];
                        print("item---${item}");
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            elevation: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                color: Colors.grey[50],
                                child: ListTile(
                                  title: Text(
                                    item.subject,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    item.status,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: item.status == "open"
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                  ),
                                  subtitle: Text(
                                    item.fullDescription,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  selected: true,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
        },
      ),
    );
  }
}
