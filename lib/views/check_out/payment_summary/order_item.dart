import 'package:flutter/material.dart';
import 'package:khapa_shapa/models/cart_model.dart';

class OrderItem extends StatelessWidget {
 final CartModel e;
  OrderItem({required this.e});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        e.cartImage,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            e.cartName,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            "Rs ${e.cartPrice  * e.cartQuantity}",

          ),
        ],
      ),
      subtitle: Text("Quantity: ${e.cartQuantity}"),
    );
  }
}