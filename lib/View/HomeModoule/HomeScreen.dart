import 'package:computer_service/View/HomeModoule/BottomNavbar.dart';
import 'package:computer_service/View/HomeModoule/DashboardPage.dart';
import 'package:computer_service/View/HomeModoule/MyProductPage.dart';
import 'package:computer_service/View/HomeModoule/MyServicePage.dart';
import 'package:computer_service/View/HomeModoule/SerVicesPage.dart';
import 'package:computer_service/View/HomeModoule/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../MainDrawer/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  int page = 0;
  PageController _pageController = PageController();

  initState() {
    _pageController = PageController(initialPage: page);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  int _lastTimeBackButtonWasTapped;

  Future<bool> onWillPop() {
    final _currentTime = DateTime.now().millisecondsSinceEpoch;
    if (_lastTimeBackButtonWasTapped != null &&
        (_currentTime - _lastTimeBackButtonWasTapped) < 2000) {
      Fluttertoast.cancel();
      return Future.value(true);
    } else {
      _lastTimeBackButtonWasTapped = DateTime.now().millisecondsSinceEpoch;
      Fluttertoast.cancel();
      Fluttertoast.showToast(
          msg: 'Press BACK again to exit',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontSize: 14.0);
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        drawer: const MainDrawer(),
        body: Container(
          color: Colors.orange,
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              DashboardPage(),
              SerVicesPage(),
              MyProductPage(),
              MyServicePage(),
              MyProfilePage()
            ],
          ),
        ),
        bottomNavigationBar:
            BottomNavbar(onTabTapped: onTabTapped, currentIndex: currentIndex),
      ),
    );
  }
}
