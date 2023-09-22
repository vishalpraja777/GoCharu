import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:follow_dp/controller/auth_controller.dart';
import 'package:follow_dp/controller/crud_crontroller.dart';

// Colors

const backgroundColor = Colors.black;
// var buttonColor = const Color.fromARGB(255, 0, 165, 39);
const borderColor = Colors.grey;
// const lightBlack1 = Color.fromRGBO(0, 255, 85, 1.0);
const primaryColor = Colors.orange;

// Images

const String logo = "assets/images/logo.png";
const String phoneLogo = "assets/images/img1.png";
const String avatar = "assets/images/avatar.png";
const String login = "assets/images/login.png";
const String register = "assets/images/register.png";
const String logincrop = "assets/images/logincrop.png";
const String googlelogo = "assets/images/googlelogo.png";
const String applogo = "assets/images/applogo.png";

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

var authController = AuthController.instance;
var crudController = CrudController.instance;
