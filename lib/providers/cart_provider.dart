import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khapa_shapa/models/cart_model.dart';

class CartProvider with ChangeNotifier{

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addReviewCartData({
   required String cartId,
    required String cartName,
    required String cartImage,
    required int cartPrice,
    required int cartQuantity,
    required String cartDescription,


  }) async {
    _firestore
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .set(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "cartDescription": cartDescription,
        "isAdd":true,
      },
    );
  }


  void updateReviewCartData({
    required String cartId,
    required String cartName,
    required String cartImage,
    required String cartDescription,
    required int cartPrice,
    required int cartQuantity,
  }) async {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .update(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "cartDescription": cartDescription,
        "isAdd":true,
      },
    );
  }



  List<CartModel> reviewCartDataList = [];
  void getReviewCartData() async {
    List<CartModel> newList = [];

    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .get();
    reviewCartValue.docs.forEach((element) {
     CartModel reviewCartModel = CartModel(
        cartId: element.get("cartId"),
        cartImage: element.get("cartImage"),
        cartName: element.get("cartName"),
        cartPrice: element.get("cartPrice"),
        cartQuantity: element.get("cartQuantity"),
        cartDescription: element.get("cartDescription"),
        //cartUnit: element.get("cartUnit"),
      );
      newList.add(reviewCartModel);
    });
    reviewCartDataList = newList;
    notifyListeners();
  }

  List<CartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }



  ////////////// ReviewCartDeleteFunction ////////////
  reviewCartDataDelete(cartId) {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .delete();
    notifyListeners();
  }

//// TotalPrice  ///

  getTotalPrice(){
    double total = 0;
    reviewCartDataList.forEach((element) {
      total += element.cartPrice * element.cartQuantity;

    });
    return total;
  }

  deletecart() async{
    final collection = await  FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart").get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }

    return batch.commit();


  }




}