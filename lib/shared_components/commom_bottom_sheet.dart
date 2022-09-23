import 'package:flutter/material.dart';

Future<T> showCommonBottomSheet<T>(
    {@required BuildContext context,
    @required Widget child,
    bool isScrollControlled = true,
    bool isDismissible = true,
    final shape,
    double elevation = 1,
    Color backgroundColor = Colors.white,
    bool enableDrag = true}) {
  return showModalBottomSheet<T>(
    isDismissible: isDismissible,
    context: context,
    isScrollControlled: isScrollControlled,
    elevation: elevation,
    backgroundColor: backgroundColor,
    enableDrag: enableDrag,
    constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top),
    shape: shape != null
        ? shape
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          )),
    builder: (BuildContext context) {
      return child;
    },
  );
}
