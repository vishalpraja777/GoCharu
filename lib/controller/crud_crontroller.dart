import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:follow_dp/constants/constants.dart';
import 'package:follow_dp/models/user_model.dart';
import 'package:get/get.dart';

class CrudController extends GetxController {
  static CrudController instance = Get.find();
  final CollectionReference links = firestore.collection("feedlinks");
  final CollectionReference profile = firestore.collection("users");

  // Future<UserModel> getUserDetails(String email) async {
  //   print(email);
  //   final snapshot = await profile.where("email", isEqualTo: email).get();
  //   final userData = snapshot.docs.map((e) => UserModel.fromSnap(e)).single;
  //   // print(userData);

  //   return userData;
  // }

  Future<UserModel> getUserDetails(String uid) async {
    print(uid);
    final snapshot = await profile.where("uid", isEqualTo: uid).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnap(e)).single;
    // print(userData);

    return userData;
  }

  Future updateProfile(UserModel userModel) async {
    await profile.doc(userModel.uid).update(userModel.toJson());
    firebaseAuth.currentUser!.updateDisplayName(userModel.username);
  }
}
