import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khapa_shapa/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //DEALS LIST
  List<ProductModel> dealsList = [];

  //POPULAR LIST
  List<ProductModel> popularList = [];


  //SEARCH LIST
  List<ProductModel> searchList = [];

  ProductModel? productModel;

  productModels(QueryDocumentSnapshot data) {
    productModel = ProductModel(
      productId: data.get('productId'),
      productImage: data.get('productImage'),
      productName: data.get('productName'),
      productPrice: data.get('productPrice'),
      productDescription: data.get('productDescription'),

    );
    searchList.add(productModel!);
  }

  fetchDealsData() async {
    List<ProductModel> newDealsList = [];
    QuerySnapshot value = await _firestore.collection("deals").get();

    value.docs.forEach((deals) {
      productModels(deals);
      newDealsList.add(productModel!);
    });

    dealsList = newDealsList;
    notifyListeners();
  }

  List<ProductModel> get getDealsDataList {
    return dealsList;
  }

  fetchPopularData() async {
    List<ProductModel> newPopularList = [];
    QuerySnapshot value = await _firestore.collection("popular").get();

    value.docs.forEach((popular) {
      productModels(popular);
      newPopularList.add(productModel!);
    });

    popularList = newPopularList;
    notifyListeners();
  }

  List<ProductModel> get getPopularDataList {
    return popularList;
  }

  //SEARCH
  List<ProductModel> get getSearchDataList {
    return searchList;
  }

}
