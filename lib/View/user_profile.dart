import 'package:computer_service/View/profile_avatar.dart';
import 'package:flutter/material.dart';

class UserProfileData {
  final String image;
  final String name;
  final String subTitle;

  const UserProfileData({
    this.image,
    this.name,
    this.subTitle,
  });
}

class UserProfile extends StatelessWidget {
  const UserProfile({
    this.data,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final UserProfileData data;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              _buildImage(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildName(),
                    _buildSubTitle(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ProfileAvatar(
      image: data.image,
      maxRadius: 30,
      defaultImage: 'assets/man.png',
    );
  }

  Widget _buildName() {
    return Text(
      data.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubTitle() {
    return Text(
      data.subTitle,
      style: TextStyle(fontWeight: FontWeight.w300, color: Colors.blue),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
