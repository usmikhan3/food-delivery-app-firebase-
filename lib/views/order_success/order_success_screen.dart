import 'package:flutter/material.dart';
import 'package:khapa_shapa/providers/cart_provider.dart';
import 'package:khapa_shapa/utils/colors.dart';
import 'package:khapa_shapa/views/home/home_screen.dart';
import 'package:provider/provider.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({Key? key}) : super(key: key);

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CartProvider cartProvider = Provider.of<CartProvider>(context,listen: false);
    cartProvider.deletecart();
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/done.gif",height: 200,width: 200,),
              SizedBox(height: 20,),
            MaterialButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
            },
            child: Text("Go Back"),
            color: primaryColor,),




          ],
        ),
      ),
    );
  }
}
