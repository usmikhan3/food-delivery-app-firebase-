import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khapa_shapa/providers/wishlist_provider.dart';
import 'package:khapa_shapa/utils/colors.dart';
import 'package:khapa_shapa/views/cart/cart_screen.dart';
import 'package:khapa_shapa/widgets/count_widget.dart';
import 'package:provider/provider.dart';

class ProductOverview extends StatefulWidget {
  final String productImage;
  final String productTitle;
  final int productPrice;
  final String productDescription;
  final String productId;

  const ProductOverview({
    Key? key,
    required this.productTitle,
    required this.productImage,
    required this.productPrice,
    required this.productDescription,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool wishListBool = false;

  getWishListBool() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(widget.productId).get().then((value) {
      if (this.mounted)
      {
        if (value.exists)
        {
          setState(
                () {
              wishListBool = value.get("wishList");
            },
          );
    }
    }
    });
  }

  Widget CustombottomNavigatorBar({
    required Color iconColor,
    required Color backgroundColor,
    required Color color,
    required String title,
    required IconData iconData,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 20,
                color: iconColor,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);
   getWishListBool();

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          CustombottomNavigatorBar(
              backgroundColor: textColor,
              color: Colors.white70,
              iconColor: Colors.grey,
              title: "Add To WishList",
              iconData: wishListBool == false
                  ? Icons.favorite_outline
                  : Icons.favorite,
              onTap: () {
                setState(() {
                  wishListBool = !wishListBool;
                });
                if (wishListBool == true) {
                  wishListProvider.addWishListData(
                      wishListId: widget.productId,
                      wishListImage: widget.productImage,
                      wishListName: widget.productTitle,
                      wishListPrice: widget.productPrice,
                      wishListQuantity: 2);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Added to wish list"),
                    duration: Duration(seconds: 1),
                  ));
                } else {
                  wishListProvider.deleteWishtList(widget.productId);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Removed from wish list"),
                    duration: Duration(seconds: 1),
                  ));
                }
              }),
          CustombottomNavigatorBar(
              backgroundColor: primaryColor,
              color: textColor,
              iconColor: Colors.white70,
              title: "Go To Cart",
              iconData: Icons.shop_outlined,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              }),
        ],
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "Product Overview",
          style: TextStyle(color: textColor),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: h * 0.5,
            //color: Colors.red,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    widget.productTitle,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Rs ${widget.productPrice}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: CountWidget(
                      productName: widget.productTitle,
                      productImage: widget.productImage,
                      productPrice: widget.productPrice,
                      productId: widget.productId,
                      productDescription: widget.productDescription,

                    ),
                  ),
                ),
                Spacer(),
                Container(
                  height: h * 0.3,
                  child: Image.network(
                    widget.productImage,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "About this Deal",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.productDescription,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
