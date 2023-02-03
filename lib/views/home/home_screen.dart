import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khapa_shapa/providers/product_provider.dart';
import 'package:khapa_shapa/providers/user_provider.dart';
import 'package:khapa_shapa/utils/colors.dart';
import 'package:khapa_shapa/views/auth/sign_in.dart';
import 'package:khapa_shapa/views/cart/cart_screen.dart';
import 'package:khapa_shapa/views/home/single_product.dart';
import 'package:khapa_shapa/views/product_overview/product_overview.dart';
import 'package:khapa_shapa/views/search/search_screen.dart';
import 'package:khapa_shapa/widgets/single_product_card.dart';
import 'package:provider/provider.dart';

import 'drawer_side.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ProductProvider? productProvider;
  UserProvider? userProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductProvider productProviderr = Provider.of<ProductProvider>(context,listen: false);
    productProviderr.fetchDealsData();
    productProviderr.fetchPopularData();

  }


  @override
  Widget build(BuildContext context) {

    productProvider = Provider.of<ProductProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
    userProvider!.getUserData();


    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      drawer: DrawerSide(userProvider:userProvider!),
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Home',
          style: TextStyle(color: textColor, fontSize: 17),
        ),
        actions: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Color(0xffd6d382),
            child: IconButton(
              onPressed: () {
                 Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        SearchScreen(
                          search: productProvider!.getSearchDataList,
                        ),
                  ),
                );
              },
              icon: Icon(
                Icons.search,
                size: 17,
                color: textColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundColor: Color(0xffd6d382),
                radius: 15,
                child: Icon(
                  Icons.shopping_cart,
                  size: 17,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBanner(context),
            _buildDeals(context),
            _buildPopular(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner(context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: MediaQuery.of(context).size.height / 5.5,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://img.freepik.com/premium-photo/hamburger-delivery-3d-rendering_256339-889.jpg?w=996'),
            colorFilter:
            ColorFilter.mode(Colors.black26, BlendMode.darken),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(right: 130, bottom: 10),
                      child: Container(
                        //margin:  const EdgeInsets.only(right: 130),
                        height: 50,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: Color(0xffd1ad17),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'DEALS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                BoxShadow(
                                    color: Colors.green,
                                    blurRadius: 7,
                                    offset: Offset(3, 3))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '30% Off',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.green[100],
                          fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'On all deals only on Weekends',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeals(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Deals',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(
                          search: productProvider!.getDealsDataList,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'view all',
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              /*children: [
                SingalProduct(
                  productImage: 'assets/images/deal1.png',
                  productName: 'Deal # 1',
                  onTap: () {
                    print("click");
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductOverview(
                      productPrice: "Rs 650",
                      productImage: 'assets/images/deal1.png',
                      productTitle:'Deal # 1' ,
                    )));
                  },
                  productPrice: "Rs 650",
                ),

              ],*/
              children: productProvider!.getDealsDataList.map((e) {
                return SingleProduct(
                  productId: e.productId,
                  productImage: e.productImage,
                  productName:e.productName,
                  productDescription: e.productDescription,
                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductOverview(
                      productPrice:e.productPrice,
                      productImage: e.productImage,
                      productTitle:e.productName ,
                      productDescription: e.productDescription,
                      productId: e.productId,
                    )));
                  },
                  productPrice: e.productPrice,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopular(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(
                          search: productProvider!.getPopularDataList,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'view all',
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
             /* children: [

               SingalProduct(
                  productImage: 'assets/images/popular1.png',
                  productName: 'Mighty Zinger',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductOverview(
                      productPrice: "Rs 250",
                      productImage: 'assets/images/popular1.png',
                      productTitle:'Mighty Zinger' ,
                    )));
                  },
                  productPrice: "Rs 250",
                ),




              ],*/

              children:  productProvider!.getPopularDataList.map((e) {
                return  SingleProduct(
                  productId: e.productId,
                  productImage: e.productImage,
                  productName: e.productName,
                  productDescription: e.productDescription,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductOverview(
                      productPrice: e.productPrice,
                      productImage: e.productImage,
                      productTitle:e.productName ,
                      productDescription: e.productDescription,
                      productId: e.productId,

                    )));
                  },
                  productPrice: e.productPrice,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
