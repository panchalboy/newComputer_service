import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  int currentIndex;
  Function onTabTapped;

  BottomNavbar({Key key, this.onTabTapped, this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.electrical_services_rounded),
          icon: Icon(Icons.electrical_services_rounded),
          label: "Products",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.miscellaneous_services_rounded),
          icon: Icon(Icons.miscellaneous_services_rounded),
          label: "Services",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.electrical_services_sharp),
          icon: Icon(Icons.electrical_services_sharp),
          label: "My Products",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.medical_services_sharp),
          icon: Icon(Icons.medical_services_sharp),
          label: "My Services",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.electrical_services_sharp),
          icon: Icon(Icons.person),
          label: "My Profile",
        ),
      ],
      selectedItemColor: Colors.redAccent,
      unselectedItemColor: Colors.redAccent.withOpacity(.5),
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      onTap: (value) => onTabTapped(value),
    );

    // return  BottomNavigationBar(
    //     currentIndex: index,
    //     onTap: (value) {
    //       setState(() {
    //         index = value;
    //       });
    //     },
    //     showSelectedLabels: true,
    //     selectedItemColor: Colors.white,
    //     unselectedItemColor: Colors.black,
    //     type: BottomNavigationBarType.fixed,
    //     backgroundColor: primaryColor,
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: new Icon(
    //           Icons.home,
    //         ),
    //         label: "Home",
    //       ),
    //       BottomNavigationBarItem(
    //         icon: new Icon(Icons.chat),
    //         label: "Chat",
    //       ),
    //       BottomNavigationBarItem(
    //         icon: new Icon(Icons.work),
    //         label: "DashBord",
    //       ),
    //     ],
    //   );
  }
}
