import 'package:flutter/material.dart';
import 'package:khapa_shapa/utils/colors.dart';
import 'package:khapa_shapa/widgets/count_widget.dart';

class SingleItem extends StatelessWidget {
  bool isBool = false;
  final String productImage;
  final String productName;
  final int productPrice;
  final String productDescription;
  final int? productQuantity;
  final String productId;
  VoidCallback ? onDelete;
  bool? wishList = false;
  SingleItem({
    Key? key,
    required this.isBool,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productId,
    this.productQuantity,
    this.onDelete,
    this.wishList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  child: Center(
                    child: Image.network(productImage),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "Rs $productPrice",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: isBool == false
                    ? CountWidget(productName: productName, productImage: productImage, productPrice: productPrice, productId: productId,productDescription: productDescription,)
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(onPressed:onDelete,
                        icon: Icon(Icons.delete, color: Colors.black54,)),
                       wishList == false ? CountWidget(
                            productName: productName,
                            productImage: productImage,
                            productPrice: productPrice,
                            productId: productId,
                         productDescription: productDescription,
                          ) : Container(),
                      ],
                    ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
