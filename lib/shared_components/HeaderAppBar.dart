import 'package:flutter/material.dart';

// Color(0xffF4F6FD)
class HeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  AppBar appBar;
  List<Widget> actions;
  BuildContext rootContext;
  bool showDrawerButton;

  HeaderAppBar(
      {this.title = 'Dashboard',
      this.appBar,
      this.actions,
      this.rootContext,
      this.showDrawerButton = false});

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      titleSpacing: showDrawerButton == true ? 0 : -10,
      // titleSpacing: 0,
      // iconTheme: IconThemeData(color: primaryColor),
      backgroundColor: Colors.white,
      title: Row(
        children: [
          showDrawerButton == true
              ? IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.menu,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Scaffold.of(rootContext).openDrawer();
                  },
                )
              : SizedBox(),
          SizedBox(
            width: 2,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.red),
          )
        ],
      ),
      actions: actions,
    );
  }
}
