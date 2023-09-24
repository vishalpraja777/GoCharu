import 'package:flutter/material.dart';
import 'package:follow_dp/constants/constants.dart';
import 'package:follow_dp/models/user_model.dart';
import 'package:follow_dp/views/widgets/profile_photo.dart';
import 'package:get/get.dart';

class NavigationDrawerCustom extends StatefulWidget {
  const NavigationDrawerCustom({super.key});

  @override
  State<NavigationDrawerCustom> createState() => _NavigationDrawerCustomState();
}

class _NavigationDrawerCustomState extends State<NavigationDrawerCustom> {
  String? email = firebaseAuth.currentUser!.email;
  late UserModel userData;
  String? userName = "";
  String? userEmail = "";

  var defaultImgUrl =
      "https://static.vecteezy.com/system/resources/previews/020/765/399/non_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg";

  getData() async {
    userData = await crudController.getUserDetails(email!);
    setState(() {
      userName = userData.username;
      userEmail = userData.email;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // color: primaryColor,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(cardbackground7), fit: BoxFit.cover),
        // ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                height: 1,
                color: white,
              ),
              buildMenuItems(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      color: primaryColor,
      padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
      child: Column(
        children: [
          const ProfilePhoto(radius: 52),
          const SizedBox(height: 12),
          Text(
            userName!,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            email!,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          ListTile(
              leading: const Icon(
                Icons.person,
              ),
              title: Text(
                "Update Profile",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.pushNamed(context, 'updateProfile');
              }),
          ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: Text(
                "Logout",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onTap: () {
                authController.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, 'onboarding', (route) => false);
              })
        ],
      ),
    );
  }
}
