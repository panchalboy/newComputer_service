import 'package:flutter/material.dart';

class MyProductList extends StatefulWidget {
  String image;
  String name;
  String price;
  String description;
  String descripation2;
  String orderDate;
  String recivedDate;
  Function onTap;

  MyProductList(
      {Key key,
      this.image,
      this.name,
      this.price,
      this.description,
      this.orderDate,
      this.recivedDate,
      this.onTap})
      : super(key: key);

  @override
  State<MyProductList> createState() => _MyProductListState();
}

class _MyProductListState extends State<MyProductList> {
  @override
  void initState() {
    // TODO: implement initState
    print("orefreer---${widget.orderDate}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: widget.onTap,
                  child: Container(
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: widget.image == null
                          ? Image.network(
                              widget.image,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace stackTrace) {
                                return Image.asset('assets/m2.jpg');
                              },
                            )
                          : Image.asset('assets/m2.jpg'),
                    ),
                  ),
                ),
              ),
              Flexible(
                  flex: 2,
                  child: InkWell(
                    onTap: widget.onTap,
                    child: Container(
                      height: 120,
                      padding: EdgeInsets.only(top: 8, left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            widget.description,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w100,
                                fontFamily: 'Georgia'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      " ${"\u20B9" + widget.price}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Georgia'),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                widget.orderDate.toString(),
                                style: TextStyle(
                                    fontSize: 12, fontFamily: 'Georgia'),
                              ),
                              // InkWell(
                              //   onTap: () {},
                              //   child: Container(
                              //     child: Row(
                              //       children: [
                              //         Text(
                              //           "View Detail",
                              //           style: TextStyle(
                              //               fontSize: 10,
                              //               color: Colors.green,
                              //               fontWeight: FontWeight.w200,
                              //               fontFamily: 'Georgia'),
                              //         ),
                              //         SizedBox(
                              //           width: 2,
                              //         ),
                              //         Icon(
                              //           Icons.arrow_forward,
                              //           size: 13,
                              //           color: Colors.green,
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
