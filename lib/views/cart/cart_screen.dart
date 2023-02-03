import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khapa_shapa/models/cart_model.dart';
import 'package:khapa_shapa/providers/cart_provider.dart';
import 'package:khapa_shapa/utils/colors.dart';

import 'package:khapa_shapa/views/check_out/deilvery_details/delivery_detail_screen.dart';
import 'package:khapa_shapa/views/product_overview/product_overview.dart';
import 'package:khapa_shapa/widgets/single_item.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatefulWidget {




  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  CartProvider? cartProvider;
  showAlertDialog(BuildContext context, CartModel delete) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        cartProvider!.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you devete on cartProduct?"),
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

    cartProvider = Provider.of<CartProvider>(context);
    cartProvider!.getReviewCartData();







    return Scaffold(
      bottomNavigationBar: ListTile(
        title: Text("Total Aount"),
        subtitle: Text(
          "Rs ${cartProvider!.getTotalPrice()}",
          style: TextStyle(
            color: Colors.green[900],
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            child: Text("Submit"),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            onPressed: () {
              if(cartProvider!.getReviewCartDataList.isEmpty){

                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text( "Your cart is empty")));
              }else{
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DeliveryDetailScreen(),
                ),
              );}
            },
          ),
        ),
      ),
     appBar: AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: textColor),
      title: Text(
        "Review Cart",
        style: TextStyle(color: textColor,fontSize: 18,),
      ),

    ),

      body:cartProvider!.getReviewCartDataList.isEmpty ? Center(
        child: Text("Cart Empty"),
      ) : ListView.builder(
        itemCount: cartProvider!.getReviewCartDataList.length,
          itemBuilder: (context,index){
            CartModel data =  cartProvider!.getReviewCartDataList[index];

          return  Column(
            children: [
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_)=>ProductOverview(
                        productId: data.cartId,
                        productDescription: data.cartDescription,
                        productPrice:data.cartPrice ,
                        productImage: data.cartImage,
                        productTitle:data.cartName,
                      )));
                },
                child: SingleItem(isBool: true,
                  productName: data.cartName,
                  productImage: data.cartImage,
                  productPrice: data.cartPrice,
                  productDescription:data.cartDescription,
                  productQuantity: data.cartQuantity,
                  productId: data.cartId,
                    onDelete: (){

                      showAlertDialog(context, data);

                    },
                  wishList: false,
                ),
              ),


              SizedBox(height: 10,),
            ],
          );
      }),


    /*
      ListView(
        children: [
          SizedBox(height: 10,),
          SingleItem(isBool: true,
            productName: ,
            productImage: "",
            productPrice: 12,
            productDescription:"" ,

          ),


          SizedBox(height: 10,),
        ],
      ),
      */
    );
  }
}
