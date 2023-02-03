import 'package:flutter/material.dart';
import 'package:khapa_shapa/utils/colors.dart';
import 'package:khapa_shapa/widgets/count_widget.dart';



class SingleProduct extends StatelessWidget {
  final String productImage;

  final String productName;

  final int productPrice;
  final String productId;

  final String productDescription;

  final VoidCallback onTap;

  SingleProduct({
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 230,
            width: 165,
            decoration: BoxDecoration(
              color: Color(0xffd9dad9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 150,
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: Image.network(
                      productImage,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                         "Rs $productPrice",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        /*Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 5),
                                height: 25,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
// Quantity

                                    Expanded(
                                        child: Text(
                                      '50 Gram',
                                      style: TextStyle(fontSize: 10),
                                    )),

// Arrow

                                    Center(
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 19,
                                        color: Colors.brown,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

//This Is Second Rectangular Container

                            SizedBox(
                              width: 5,
                            ),

                            Container(
                              height: 25,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.remove,
                                    size: 15,
                                    color: primaryColor,
                                  ),
                                  Text(
                                    "1",
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),*/
                        CountWidget(
                          productId: productId,
                          productPrice: productPrice,
                          productImage: productImage,
                          productName: productName,
                          productDescription: productDescription,

                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
