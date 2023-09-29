import 'package:flutter/material.dart';
import 'package:follow_dp/constants/constants.dart';

class ProfilePhoto extends StatefulWidget {
  final double radius;
  final bool isEditable;

  const ProfilePhoto(
      {super.key, required this.radius, this.isEditable = false});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    var defaultImgUrl =
        "https://static.vecteezy.com/system/resources/previews/020/765/399/non_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg";

    var isPhotoUrl = false;
    var photoUrl;
    // var isEditable;

    if (firebaseAuth.currentUser!.photoURL != null) {
      setState(() {
        isPhotoUrl = true;
        photoUrl = firebaseAuth.currentUser!.photoURL;
      });
    }
    return Stack(children: [
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, "viewPhoto");
        },
        child: CircleAvatar(
          radius: widget.radius,
          backgroundImage:
              isPhotoUrl ? NetworkImage(photoUrl) : NetworkImage(defaultImgUrl),
        ),
      ),
      Positioned(
          bottom: -widget.radius * 0.2,
          left: widget.radius * 1.25,
          child: widget.isEditable
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      photoUrl = authController.pickImage();
                    });
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                )
              : Container())
    ]);
  }
}
