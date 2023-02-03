import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khapa_shapa/models/user_model.dart';

class UserProvider with ChangeNotifier{

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addUserData(
      {
        required User currentUser,
        required String userName,
        required String userEmail,
        required String userImage,
  }
  ) async{
   await  FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "userId": currentUser.uid,
      "userName": userName,
      "userEmail":userEmail,
      "userImage": userImage,

    });
  }

  UserModel? currentData;

  void getUserData() async {
    UserModel userModel;
    var value = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
        userEmail: value.get("userEmail"),
        userImage: value.get("userImage"),
        userName: value.get("userName"),
        userUid: value.get("userId"),
      );
      currentData = userModel;
      notifyListeners();
    }
  }

  UserModel get currentUserData {
    return currentData!;
  }



}