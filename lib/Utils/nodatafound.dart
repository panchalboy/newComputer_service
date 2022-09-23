import 'package:flutter/material.dart';

class NoDataFound extends StatefulWidget {
  String text;
  //String url;
  double height;
  @override
  _NoDataFoundState createState() => _NoDataFoundState();

  NoDataFound({this.text = null, this.height = 0.25});
}

class _NoDataFoundState extends State<NoDataFound> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          ['', null].contains(widget.text)
              ? SizedBox()
              : Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      // color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                )
        ],
      ),
    );
  }
}
