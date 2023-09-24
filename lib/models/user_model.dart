import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? uid;
  final String? profilePhoto;
  final String username;
  final String dob;
  final String email;
  final String phoneNumber;
  final String gender;

  UserModel(
      {this.uid,
      this.profilePhoto,
      required this.username,
      required this.dob,
      required this.email,
      required this.phoneNumber,
      required this.gender});

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "profilePhoto": profilePhoto,
      "username": username,
      "dob": dob,
      "email": email,
      "phoneNumber": phoneNumber,
      "gender": gender,
    };
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        uid: snapshot['uid'],
        email: snapshot['email'],
        profilePhoto: snapshot['profilePhoto'],
        username: snapshot['username'],
        dob: snapshot['dob'],
        phoneNumber: snapshot['phoneNumber'],
        gender: snapshot['gender']);
  }
}
