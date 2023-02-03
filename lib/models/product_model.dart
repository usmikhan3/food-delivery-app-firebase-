class ProductModel {
  String productName;
  String productImage;
  String productDescription;
  int productPrice;
  String productId;
  int? productQuantity;


  ProductModel(
      {
        //required this.productQuantity,
      required this.productId,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productDescription,
        this.productQuantity,
      });
}
