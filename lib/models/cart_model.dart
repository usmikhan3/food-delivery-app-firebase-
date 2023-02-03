class CartModel {
  String cartId;
  String cartImage;
  String cartName;
  int cartPrice;
  int cartQuantity;
  String cartDescription;
  //var cartUnit;
  CartModel({
   required this.cartId,
    //required this.cartUnit,
    required this.cartImage,
    required this.cartName,
    required this.cartPrice,
    required this.cartQuantity,
    required this.cartDescription,
  });
}