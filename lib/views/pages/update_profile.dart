import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String? uid = firebaseAuth.currentUser!.uid;
  late UserModel userData;
  bool isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  String genderValue = "Male";
  List<String> genderList = <String>["Male", "Female", "Other"];

  DateTime dateTime = DateTime.now();
  String strDateTime = '--/--/----';

  getData() async {
    // userData = await crudController.getUserDetails(email!);
    userData = await crudController.getUserDetails(uid!);
    print(userData.email);
    setState(() {
      _emailController.text = userData.email;
      _userNameController.text = userData.username;
      _genderController.text = userData.gender;
      _phoneNumberController.text = userData.phoneNumber;
      _dobController.text = userData.dob;
      strDateTime = _dobController.text;
      genderValue = _genderController.text;
    });
  }

  _chooseImage() {
    setState(() async {
      var res = await authController.pickImage();
      if (res != null) {
        Fluttertoast.showToast(
            msg: "Profile Photo Chnaged\nWill be updated in sometime");
      }
      isLoading = false;
    });
  }

  _deleteImage() {
    authController.updateProfileWithPhoto('');
    Fluttertoast.showToast(
        msg: "Profile Photo deleted\nWill be updated in sometime");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // var defaultImgUrl =
    //     "https://static.vecteezy.com/system/resources/previews/020/765/399/non_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg";

    // var isPhotoUrl = false;
    // var photoUrl;
    if (firebaseAuth.currentUser!.photoURL != null) {
      // isPhotoUrl = true;
      // photoUrl = firebaseAuth.currentUser!.photoURL;
    }

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: primaryColor,
      body: Column(
        children: [_buildTop(), const SizedBox(height: 20), _buildBottom()],
      ),
      // body: Stack(
      //   children: [
      //     Align(alignment: Alignment.topCenter, child: _buildTop()),
      //     Align(alignment: Alignment.bottomCenter, child: _buildBottom()),
      //   ],
      // ),
    );
  }

  Widget _buildTop() {
    return Column(
      children: [
        Container(
            // height: MediaQuery.of(context).size.height * 0.2,
            color: primaryColor,
            // width: MediaQuery.of(context).size.width,
            // height: 200,
            padding: const EdgeInsets.only(top: 20),
            child: const Center(
                child: ProfilePhoto(
              radius: 64.0,
              isEditable: false,
            ))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  _chooseImage();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, shadowColor: Colors.white),
                child: const Text(
                  'Choose Image',
                  style: TextStyle(color: primaryColor),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _deleteImage();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, shadowColor: Colors.white),
                child: const Text(
                  'Delete Image',
                  style: TextStyle(color: primaryColor),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBottom() {
    return Expanded(
      child: Container(
        // height: MediaQuery.of(context).size.height * 1,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          color: Colors.white,
        ),
        // padding: const EdgeInsets.only(top: 32, bottom: 2, left: 32, right: 32),
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.only(top: 32, bottom: 2, left: 32, right: 32),
            child: Column(
              children: [
                const Text("Enter the fields to Update"),
                const SizedBox(height: 20),
                // name input
                TextInputField(
                  controller: _userNameController,
                  labelText: "Name",
                  icon: Icons.person,
                  signup: false,
                  isObscure: false,
                ),
                const SizedBox(height: 25),
                // gender input
                _dropDownList(),
                const SizedBox(height: 20),
                // phone number input
                TextInputField(
                  controller: _phoneNumberController,
                  labelText: "Phone Number",
                  icon: Icons.phone,
                  signup: false,
                  numberic: true,
                  isObscure: false,
                ),
                const SizedBox(height: 20),
                // DOB input
                _datePicker(context),
                const SizedBox(height: 30),
                // Update Button
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        _genderController.text = genderValue;
                        UserModel userModel = UserModel(
                            uid: firebaseAuth.currentUser!.uid,
                            username: _userNameController.text,
                            dob: _dobController.text,
                            email: _emailController.text,
                            phoneNumber: _phoneNumberController.text,
                            profilePhoto: firebaseAuth.currentUser!.photoURL,
                            gender: _genderController.text);

                        crudController.updateProfile(userModel);

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'homepage',
                          (route) => false,
                        );
                      },
                      // style: ElevatedButton.styleFrom(),
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropDownList() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16), // Remove internal padding
        border: OutlineInputBorder(
          // Customize the border
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      isExpanded: true,
      value: genderValue,
      items: genderList
          .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
          .toList(),
      onChanged: (String? value) {
        setState(() {
          genderValue = value!;
        });
      },
    );
  }

  Widget _datePicker(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("DOB: $strDateTime"),
          SizedBox(
              child: ElevatedButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) => showCupertinoDatePicker(context));
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: const Text("Choose DOB"))))
        ],
      ),
    );
  }

  showCupertinoDatePicker(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          color: Colors.white),
      height: 250,
      child: CupertinoDatePicker(
        // backgroundColor: Colors.white,
        initialDateTime: dateTime,
        maximumDate: DateTime.now(),
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (DateTime newTime) {
          setState(() {
            dateTime = newTime;
            strDateTime = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
            _dobController.text = strDateTime;
          });
        },
      ),
    );
  }
}
