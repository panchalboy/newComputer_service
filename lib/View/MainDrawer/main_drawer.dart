import 'package:computer_service/View/create_support.dart';
import 'package:computer_service/shared_components/selection_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Routes/routes.dart';
import '../HomeModoule/my_profile.dart';
import '../user_profile.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrwerState();
}

onSelectedMainMenu(int index, SelectionButtonData value) {
  // Navigator.pop(context);
  switch (value.label.toUpperCase()) {
    case 'CREATE TICKET':
      return Get.toNamed(
        Routes.CREATE_SUPPORT,
      );
    case 'MY TICKETS':
      return Get.toNamed(
        Routes.GET_ALL_SUPPORT,
      );
    case 'PRIVACY & POLICY':
      return Get.toNamed(
        Routes.PRIVACY_POLICY,
      );
    case 'CONTACT US':
      return Get.toNamed(
        Routes.CONTACT_US,
      );

    default:
      return;
  }
}

class _MainDrwerState extends State<MainDrawer> {
  String username = '';
  String subtitle = '';
  String userProfileImage = '';
  GetStorage storage = GetStorage();

  @override
  initState() {
    super.initState();
    setState(() {
      username = storage.read('name');
      userProfileImage = storage.read('user_image');
      subtitle = storage.read('email') != null
          ? storage.read('email')
          : storage.read('phone');
    });

    storage.listenKey('name', (value) {
      if (value == null) return;
      if (mounted) {
        setState(() {
          username = value;
        });
      }
    });

    storage.listenKey('email', (value) {
      if (value == null) return;
      if (mounted) {
        setState(() {
          subtitle = value;
        });
      }
    });

    storage.listenKey('phone', (value) {
      if (value == null) return;
      if (mounted) {
        setState(() {
          subtitle = value;
        });
      }
    });

    storage.listenKey('user_image', (value) {
      if (mounted) {
        setState(() {
          userProfileImage = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          height: 120,
          child: DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                  decoration: BoxDecoration(),
                  child:
                      SingleChildScrollView(child: _buildSidebar(context))))),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: UserProfile(
            data: UserProfileData(
              image: userProfileImage,
              name: username,
              subTitle: subtitle,
            ),
            onPressed: () {
              // Get.to(MyProfilePage());
            },
          ),
        ),
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: _MainMenu(onSelected: onSelectedMainMenu),
        ),
      ],
    );
  }
}

class _MainMenu extends StatelessWidget {
  const _MainMenu({
    this.onSelected,
    Key key,
  }) : super(key: key);

  final Function(int index, SelectionButtonData value) onSelected;

  @override
  Widget build(BuildContext context) {
    return SelectionButton(
      data: [
        SelectionButtonData(
          activeIcon: Icons.home,
          icon: Icons.home_outlined,
          label: "Create Ticket",
        ),
        SelectionButtonData(
          activeIcon: Icons.mail,
          icon: Icons.mail_outline,
          label: "My Tickets",
          // totalNotif: 100,
        ),
        SelectionButtonData(
          activeIcon: Icons.book,
          icon: Icons.book_online_outlined,
          label: "Privacy & Policy",
        ),
        SelectionButtonData(
          activeIcon: Icons.link,
          icon: Icons.link_off_outlined,
          label: "Contact us",
        ),
      ],
      onSelected: onSelected,
      key: null,
    );
  }
}
