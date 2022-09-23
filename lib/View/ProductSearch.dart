import 'package:computer_service/View/productdetails/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:get/get.dart';

import '../Routes/routes.dart';
import '../shared_components/common_list_ui.dart';

final debouncer =
    Debouncer<String>(Duration(milliseconds: 300), initialValue: "");

class SearchProduct extends SearchDelegate<String> {
  List items = [];

  Function onTap;
  Function onSearch;
  SearchProduct({this.onTap, this.onSearch});

  @override
  String get searchFieldLabel => "Search Product";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Colors.red, // affects AppBar's background color
        textTheme: const TextTheme(
            headline5: TextStyle(
                // headline 6 affects the query text
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  ///OnSubmit in the keyboard, returns the [query]
  @override
  void showResults(BuildContext context) {
    close(context, query);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox();
  }

  queryChanged(String query) async {
    if (debouncer.value == query) return items;
    debouncer.value = query;
    return onSearch(await debouncer.nextValue);
  }

  onClick(context, it) {
    close(context, "");
    onTap(it);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.2;

    final double itemWidth = size.width / 2;
    return FutureBuilder(
        future:
            onSearch != null && query.isNotEmpty ? queryChanged(query) : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            items = snapshot.data as List;
            print("item----$items");
            if (items.isEmpty)
              return Center(
                child: Text(
                  'No search found.',
                  style: TextStyle(color: Colors.black),
                ),
              );
            return GridView.builder(
                itemCount: items.length,
                controller: ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (itemWidth / itemHeight),
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.5,
                    crossAxisSpacing: 5.5),
                itemBuilder: (context, index) {
                  var item = items[index];
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
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'No search found.',
                style: TextStyle(color: Colors.black),
              ),
            );
          } else {
            return Center(
              child: Text(
                'Search Product',
                style: TextStyle(color: Colors.black),
              ),
            );
          }
        });
  }
  // ignore: non_constant_identifier_names
}

class ProductList extends StatelessWidget {
  var item;
  Function onClick;
  ProductList({this.item, this.onClick});

  @override
  Widget build(BuildContext context) {
    print("productdd--$item");

    var image = item.productImg;
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
          child: Row(children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(image),
            ),
            //AvatarImage(title: item.workspace != null ? item.workspace['title']:item.title,subtitle: item.workspace != null ? item.workspace['title']:null,maxRadius: 24,image: getChatAvatarImage(item)),
            Expanded(
                child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "\u{20B9}${item.salePrice}",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.normal),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )),
          ]),
          height: 66),
      onTap: () {
        print("item----$item");
        Get.to(ProductDetailScreen(
          id: item.id,
          type: "PRODUCT",
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
      },
    );
  }
}
