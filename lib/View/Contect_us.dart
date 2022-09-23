import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ContactUS extends StatefulWidget {
  const ContactUS({Key key}) : super(key: key);

  @override
  State<ContactUS> createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  _launchEmail() async {
    String email = 'email:info@rapidworld.com';
    String subject = 'This is a test email';
    String body = 'This is a test email body';

    String emailUrl = "mailto:$email?subject=$subject&body=$body";
    UrlLauncher.launch(emailUrl);
  }

  openwhatsapp() async {
    var whatsapp = "+919509791950";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      UrlLauncher.launch(whatsappURl_android);
      // if (await launch(whatsappURl_android)) {
      //   await launch(whatsappURl_android);
      // } else {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      // }
    }
  }

  onCall(phone) {
    UrlLauncher.launch("tel:${phone.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Contact us"),
        foregroundColor: Colors.red[500],
      ),
      body: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                _launchEmail();
              },
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text("info@rapidworld.com"),
                subtitle: Text("Email us"),
              )),
          InkWell(
              onTap: () {
                onCall('9509791950');
              },
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text("9509791950"),
                subtitle: Text("Call us"),
              )),
          InkWell(
              onTap: () {
                openwhatsapp();
              },
              child: ListTile(
                leading: Icon(Icons.whatsapp),
                title: Text("9509791950"),
                subtitle: Text("Whatsapp us"),
              )),
        ],
      )),
    );
  }
}
