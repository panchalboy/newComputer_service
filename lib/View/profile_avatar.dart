import 'dart:io';

import 'package:flutter/material.dart';

class ProfileAvatar extends StatefulWidget {
  dynamic image;
  String title;
  double maxRadius;
  double upRadius;
  Color borderColor;
  bool isFile;
  String defaultImage;

  ProfileAvatar(
      {this.image,
      this.title,
      this.maxRadius,
      this.upRadius,
      this.borderColor = Colors.transparent,
      this.isFile = false,
      this.defaultImage = 'assets/man.png'});

  @override
  ProfileAvatarState createState() => ProfileAvatarState();
}

class ProfileAvatarState extends State<ProfileAvatar> {
  bool imageLoadError = false;

  getBackgrounImage() {
    if (widget.isFile)
      return FileImage(File(widget.image.path));
    else
      return imageLoadError || ['', null].contains(widget.image)
          ? AssetImage(widget.defaultImage ?? 'assets/man.png')
          : NetworkImage(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          Container(
              child: widget.image != null || widget.defaultImage != null
                  ? CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: widget.upRadius,
                      child: CircleAvatar(
                        backgroundImage: getBackgrounImage(),
                        radius: widget.maxRadius,
                        // maxRadius: widget.maxRadius,
                        backgroundColor: Colors.transparent,
                        onBackgroundImageError: (res, error) {
                          setState(() {
                            imageLoadError = true;
                          });
                        },
                      ),
                    )
                  : CircleAvatar(
                      child: Text(
                        widget.title
                            .toString()
                            .replaceAll(' ', '')
                            .substring(0, 1)
                            .toUpperCase(),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      maxRadius: widget.maxRadius,
                    ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(width: 1, color: widget.borderColor))),
        ],
      ),
    );
  }
}
