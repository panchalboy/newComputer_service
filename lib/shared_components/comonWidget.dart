import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

toastWidget(msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      //timeInSecForIosWeb: 1,
      // backgroundColor: primaryColor,
      textColor: Colors.white,
      fontSize: 14.0);
}

commonLoader() {
  return Center(
    child: Container(
      child: CircularProgressIndicator(
        strokeWidth: 3,
      ),
      height: 24,
      width: 24,
    ),
  );
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}

commonAlertDialog(context, title, description, cancelbutton, okbutton,
    {Function onTap}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
              style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
              onPressed: () {
                onTap(false);
                Navigator.pop(context);
              },
              child: Text(cancelbutton)),
          TextButton(
              style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                  ),
              onPressed: () {
                onTap(true);
                Navigator.pop(context);
              },
              child: Text(okbutton))
        ],
      );
    },
  );
}
