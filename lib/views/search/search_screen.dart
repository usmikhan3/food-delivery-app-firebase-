import 'package:flutter/material.dart';
import 'package:khapa_shapa/models/product_model.dart';
import 'package:khapa_shapa/utils/colors.dart';
import 'package:khapa_shapa/views/product_overview/product_overview.dart';
import 'package:khapa_shapa/widgets/single_item.dart';


class SearchScreen extends StatefulWidget {
  final List<ProductModel> search;

  const SearchScreen({Key? key,required this.search}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String query = "";


  searchItem(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }



  @override
  Widget build(BuildContext context) {
    List<ProductModel> _searchItem = searchItem(query);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "Search",
          style: TextStyle(color: textColor,fontSize: 18,),
        ),
        actions: const[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.menu_rounded),
          ),
        ],
      ),

      body: ListView(
        children: [
          const ListTile(
            title: Text("Items"),
          ),
           Container(
            height: 52,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value){
                print(value);
                setState(() {
                  query = value;
                });
              },onSubmitted: (value){
              print(value);
              setState(() {
                query = value;
              });
            },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none
                ),
                fillColor: Color(0xFFc2c2c2),
                filled: true,
                hintText: "Search for your food",
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Column(
            children: _searchItem.map((e) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (_)=>ProductOverview(
                    productId: e.productId,
                    productDescription: e.productDescription,
                    productPrice:e.productPrice ,
                    productImage: e.productImage,
                    productTitle:e.productName ,
                  )));
                },
                child: SingleItem(
                  isBool: false,
                  productName: e.productName,
                  productImage: e.productImage,
                  productPrice: e.productPrice,
                  productDescription: e.productDescription,
                  productId: e.productId,

                ),
              );
            }).toList(),
          ),


        ],
      ),
    );
  }
}
