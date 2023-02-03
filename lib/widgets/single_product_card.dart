import 'package:flutter/material.dart';
import 'package:khapa_shapa/utils/colors.dart';


class SingleProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  const SingleProductCard({Key? key,required this.title,required this.price,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 230,
      width: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFd9dad9)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex:1,
            child:  Center(child: Image.asset(image,fit: BoxFit.contain)),
          ),
          Expanded(child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                SizedBox(height: 10,),


                 Text(title,
                  style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18
                  ),),
                Text("Rs $price",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                      fontSize: 16
                  ),),
                SizedBox(height: 10,),

                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              /*if (count == 1) {
                                                Fluttertoast.showToast(
                                                  msg:
                                                  "You reach minimum limit",

                                                );
                                              } else {
                                                setState(() {
                                                  count--;
                                                });
                                                reviewCartProvider
                                                    .updateReviewCartData(
                                                  cartImage:
                                                  widget.productImage,
                                                  cartId: widget.productId,
                                                  cartName:
                                                  widget.productName,
                                                  cartPrice:
                                                  widget.productPrice,
                                                  cartQuantity: count,
                                                );
                                              }*/
                            },
                            child: Text(
                              "-",style: TextStyle(
                              color: primaryColor,
                              fontSize: 24,
                            ),
                            ),
                          ),
                          Text(
                            "0",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              /*if (count < 10) {
                                                setState(() {
                                                  count++;
                                                });
                                                reviewCartProvider
                                                    .updateReviewCartData(
                                                  cartImage:
                                                  widget.productImage,
                                                  cartId: widget.productId,
                                                  cartName:
                                                  widget.productName,
                                                  cartPrice:
                                                  widget.productPrice,
                                                  cartQuantity: count,
                                                );
                                              }*/
                            },
                            child: Text(
                              "+",style: TextStyle(
                              color: primaryColor,
                              fontSize: 22,
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),),
        ],
      ),
    );
  }
}
