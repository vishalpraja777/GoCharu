import 'package:flutter/material.dart';
import 'package:follow_dp/constants/constants.dart';
import 'package:follow_dp/models/user_model.dart';
import 'package:follow_dp/views/widgets/profile_photo.dart';
import 'package:follow_dp/views/widgets/textInputField.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String? email = firebaseAuth.currentUser!.email;
  late UserModel userData;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  getData() async {
    userData = await crudController.getUserDetails(email!);
    _emailController.text = userData.email;
    _userNameController.text = userData.username;
    _genderController.text = userData.gender;
    _phoneNumberController.text = userData.phoneNumber;
    _dobController.text = userData.dob;
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var defaultImgUrl =
        "https://static.vecteezy.com/system/resources/previews/020/765/399/non_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg";

    var isPhotoUrl = false;
    var photoUrl;
    if (firebaseAuth.currentUser!.photoURL != null) {
      isPhotoUrl = true;
      photoUrl = firebaseAuth.currentUser!.photoURL;
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const ProfilePhoto(radius: 64.0),
          const SizedBox(
            height: 25,
          ),
          // Stack(
          //   children: [
          //     const CircleAvatar(
          //       radius: 64,
          //       backgroundImage: AssetImage(avatar),
          //       // NetworkImage(
          //       //     "https://www.pngkit.com/png/detail/301-3012694_account-user-profile-avatar-comments-fa-user-circle.png"),
          //       backgroundColor: Colors.black,
          //     ),
          //     Positioned(
          //       bottom: -10,
          //       left: 80,
          //       child: IconButton(
          //         onPressed: () {
          //           authController.pickImage();
          //         },
          //         icon: const Icon(
          //           Icons.add_a_photo,
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _userNameController,
              labelText: "Name",
              signup: true,
              icon: Icons.person,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   margin: const EdgeInsets.symmetric(horizontal: 20),
          //   child: TextInputField(
          //     controller: _emailController,
          //     labelText: "Email",
          //     icon: Icons.email,
          //   ),
          // ),
          // const SizedBox(
          //   height: 25,
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _genderController,
              labelText: "Gender",
              icon: Icons.person,
              signup: true,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _phoneNumberController,
              labelText: "Mobile Number",
              signup: true,
              icon: Icons.person,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _dobController,
              labelText: "DOB",
              signup: true,
              icon: Icons.person,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: InkWell(
              onTap: () async {
                UserModel userModel = UserModel(
                    uid: firebaseAuth.currentUser!.uid,
                    username: _userNameController.text,
                    dob: _dobController.text,
                    email: _emailController.text,
                    phoneNumber: _phoneNumberController.text,
                    gender: _genderController.text);

                crudController.updateProfile(userModel);

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'homepage',
                  (route) => false,
                );
              },
              child: const Center(
                child: Text(
                  "Update",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
