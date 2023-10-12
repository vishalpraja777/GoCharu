import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:follow_dp/constants/constants.dart';
import 'package:follow_dp/models/user_model.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  // late Rx<User?> _user;

  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;

  // @override
  // void onReady() {
  //   super.onReady();
  //   _user = Rx<User?>(firebaseAuth.currentUser);
  //   _user.bindStream(firebaseAuth.authStateChanges());
  //   ever(_user, (callback) => _setInitScreen);
  // }

  // _setInitScreen(User? user) {
  //   if (user == null) {
  //     Get.offAll(() {
  //       print("inpage");
  //       LoginPage();
  //     });
  //   } else {
  //     Get.offAll(() {
  //       print("inpage1");
  //       const Homepage();
  //     });
  //   }
  // }

  pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar("Profile Picture",
          "You have successfully selected the profile picture");
      _pickedImage = Rx<File?>(File(pickedImage.path));
      String downloadUrl = await _uploadToStorage(profilePhoto!);
      firebaseAuth.currentUser?.updatePhotoURL(downloadUrl);

      // update user model
      updateProfileWithPhoto(downloadUrl);
      // UserModel userData =
      //     await crudController.getUserDetails(firebaseAuth.currentUser!.email!);
      // UserModel userModel = UserModel(
      //     uid: firebaseAuth.currentUser!.uid,
      //     username: userData.username,
      //     dob: userData.dob,
      //     email: userData.email,
      //     phoneNumber: userData.phoneNumber,
      //     gender: userData.gender,
      //     profilePhoto: downloadUrl);

      // crudController.updateProfile(userModel);

      return downloadUrl;
    }
  }

  updateProfileWithPhoto(String photoUrl) async {
    if (photoUrl == '') {
      await firebaseAuth.currentUser!.updatePhotoURL(null);
    } else {
      await firebaseAuth.currentUser!.updatePhotoURL(photoUrl);
    }
    UserModel userData =
        await crudController.getUserDetails(firebaseAuth.currentUser!.uid);
    UserModel userModel = UserModel(
        uid: firebaseAuth.currentUser!.uid,
        username: userData.username,
        dob: userData.dob,
        email: userData.email,
        phoneNumber: userData.phoneNumber,
        gender: userData.gender,
        profilePhoto: photoUrl);

    crudController.updateProfile(userModel);
  }

  // upload to firebase storage

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // sending verification mail

  Future sendVerificationEmail() async {
    try {
      Fluttertoast.showToast(msg: "Sending Verification Mail");
      final user = firebaseAuth.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error Sending Verification Mail");
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  // registering the user
  Future<bool> registerUser(String username, String email, String password,
      String phoneNumber, String gender, String dob) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          gender.isNotEmpty &&
          dob.isNotEmpty) {
        // save user to auth and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        // String downloadUrl = "";
        // if (image != null) {
        //   downloadUrl = await _uploadToStorage(image);
        // }

        firebaseAuth.currentUser!.updateDisplayName(username);

        UserModel user = UserModel(
            username: username,
            dob: dob,
            email: email,
            phoneNumber: phoneNumber,
            gender: gender,
            profilePhoto: '',
            uid: cred.user!.uid);

        await firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
        return true;
      } else {
        // Get.snackbar(
        //   "Error Creating Account",
        //   "Please Enter all the fields",
        // );
        Fluttertoast.showToast(msg: "Please Enter all the fields");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Email maybe already registered! Try logging in");
      // Get.snackbar(
      //   "Error Creating Account",
      //   e.toString(),
      // );
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && email.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        return true;
      } else {
        Fluttertoast.showToast(msg: "Please Enter all the fields");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error Logging in");
      return false;
    }
  }

  googleSignIn() async {
    try {
      // begin interactive sign in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      // obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      // create a new credential for user
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      // finally let's sign in
      var signinRes =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("signinRes");
      print(signinRes);
      if (signinRes.additionalUserInfo!.isNewUser) {
        UserModel user = UserModel(
            username: signinRes.user!.displayName!,
            dob: '',
            email: signinRes.user!.email!,
            phoneNumber: '',
            gender: '',
            profilePhoto: '',
            uid: signinRes.user!.uid);

        await firestore
            .collection("users")
            .doc(signinRes.user!.uid)
            .set(user.toJson());
      }
      print(signinRes.user!.uid);
      return signinRes;
    } catch (error) {
      Fluttertoast.showToast(msg: "Error signing, try signup");
      return null;
    }
  }

  Future resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(msg: 'Password Reset Email Sent');
      return true;
    } catch (error) {
      Fluttertoast.showToast(msg: 'Enter a valid Email');
      return false;
    }
  }
}
