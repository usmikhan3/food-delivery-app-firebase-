import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khapa_shapa/models/delivery_address_model.dart';
import 'package:location/location.dart';

class CheckOutProvider with ChangeNotifier {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController alternateNo = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  LocationData? setLocation;

  bool isLoading = false;

  void validator(BuildContext context,String myType) async {
    print(setLocation);
    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please add first name");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please add last name");
    } else if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please add mobile");
    } else if (alternateNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please add alternate Mobile No");
    } else if (area.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please add area");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please add street address");
    } else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please add landmark");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please add city");
    } else if (pinCode.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please add postal code");
    } else if (setLocation == null) {
      Fluttertoast.showToast(msg: "setLocation is empty");
    }else {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("deliveryAddresses")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
          "firstName":firstName.text,
          "lastName":lastName.text,
          "mobileNo":mobileNo.text,
          "alternateNo":alternateNo.text,
          "area":area.text,
          "street":street.text,
          "landmark":landmark.text,
          "city":city.text,
          "pinCode":pinCode.text,
          "addressType":myType,
          "longitude":setLocation!.longitude,
        "langitude":setLocation!.latitude
      }).then((value) {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: "Delivery Address added successfully");
        Navigator.pop(context);
        notifyListeners();
      });
    }
    notifyListeners();
  }

  List<DeliveryAddressModel> deliveryAddressList = [];

  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("deliveryAddresses")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (_db.exists) {
      deliveryAddressModel = DeliveryAddressModel(

        firstName: _db.get("firstName"),
        lastName: _db.get("lastName"),
        addressType: _db.get("addressType"),
        area: _db.get("area"),
        alternateMobileNo: _db.get("alternateNo"),
        city: _db.get("city"),
        landMark: _db.get("landmark"),
        mobileNo: _db.get("mobileNo"),
        pinCode: _db.get("pinCode"),
        street: _db.get("street"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }

    deliveryAddressList = newList;
    notifyListeners();
  }



  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAddressList;
  }



}
