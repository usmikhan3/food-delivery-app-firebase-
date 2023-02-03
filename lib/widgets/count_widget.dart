import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khapa_shapa/providers/cart_provider.dart';
import 'package:khapa_shapa/utils/colors.dart';
import 'package:provider/provider.dart';

class CountWidget extends StatefulWidget {
  final String productName;
  final String productImage;
  final String productId;
  final String productDescription;
  final int productPrice;

  const CountWidget({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDescription,
    required this.productId,
  }) : super(key: key);

  @override
  State<CountWidget> createState() => _CountWidgetState();
}

class _CountWidgetState extends State<CountWidget> {
  int count = 1;
  bool isAdd = false;

  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart").doc(widget.productId).get()
    .then((value){
      if(this.mounted){
        if(value.exists){
          setState(() {
            count = value.get("cartQuantity");
            isAdd = value.get("isAdd");
          });
        }

      }
    });
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddAndQuantity();
  }


  @override
  Widget build(BuildContext context) {

    getAddAndQuantity();

    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Center(
      child: isAdd == true
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (count == 1) {
                        setState(() {
                          isAdd = false;
                        });
                        cartProvider.reviewCartDataDelete(widget.productId);

                      } else {
                        setState(() {
                          count--;
                        });
                        cartProvider
                            .updateReviewCartData(
                          cartImage:
                          widget.productImage,
                          cartId: widget.productId,
                          cartName:
                          widget.productName,
                          cartPrice:
                          widget.productPrice,
                          cartQuantity: count,
                          cartDescription: widget.productId
                        );
                      }
                    },
                    child: Text(
                      "-",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Text(
                    count.toString(),
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        count++;
                      });
                             cartProvider
                          .updateReviewCartData(
                        cartImage:
                        widget.productImage,
                        cartId: widget.productId,
                        cartName:
                        widget.productName,
                        cartPrice:
                        widget.productPrice,
                        cartQuantity: count,
                               cartDescription: widget.productDescription
                      );
                    },
                    child: const Text(
                      "+",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              )),
            )
          : InkWell(
              onTap: () {
                setState(() {
                  isAdd = true;
                });
                cartProvider.addReviewCartData(
                  cartId: widget.productId,
                  cartName: widget.productName,
                  cartImage: widget.productImage,
                  cartPrice: widget.productPrice,
                  cartQuantity: count,
                  cartDescription: widget.productDescription


                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "ADD",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
