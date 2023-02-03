import 'package:flutter/material.dart';
import 'package:khapa_shapa/models/product_model.dart';
import 'package:khapa_shapa/providers/wishlist_provider.dart';
import 'package:khapa_shapa/utils/colors.dart';
import 'package:khapa_shapa/widgets/single_item.dart';
import 'package:provider/provider.dart';



class WishListScreen extends StatefulWidget {
@override
_WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  WishListProvider? wishListProvider;
  showAlertDialog(BuildContext context, ProductModel delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        wishListProvider!.deleteWishtList(delete.productId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("WishList Product"),
      content: Text("Are you sure to remove product from wishlist?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider!.getWishtListData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "WishList",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      body: ListView.builder(
        itemCount: wishListProvider!.getWishList.length,
        itemBuilder: (context, index) {
          ProductModel data = wishListProvider!.getWishList[index];
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SingleItem(
                isBool: true,
                productImage: data.productImage,
                productName: data.productName,
                productPrice: data.productPrice,
                productId: data.productId,
                productQuantity: data.productQuantity!,
                onDelete: () {
                  showAlertDialog(context,data);
                },
                productDescription: data.productDescription,
                wishList: true,
              ),
            ],
          );
        },
      ),
    );
  }
}