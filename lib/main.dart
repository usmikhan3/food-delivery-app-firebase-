import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:khapa_shapa/providers/cart_provider.dart';
import 'package:khapa_shapa/providers/check_out_provider.dart';
import 'package:khapa_shapa/providers/product_provider.dart';
import 'package:khapa_shapa/providers/user_provider.dart';
import 'package:khapa_shapa/providers/wishlist_provider.dart';
import 'package:khapa_shapa/utils/colors.dart';
import 'package:khapa_shapa/utils/constants.dart';
import 'package:khapa_shapa/views/auth/sign_in.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = PUB_KEY;
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(create: (_)=>ProductProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_)=>UserProvider()),
        ChangeNotifierProvider<CartProvider>(create: (_)=>CartProvider()),
        ChangeNotifierProvider<WishListProvider>(create: (_)=>WishListProvider()),
        ChangeNotifierProvider<CheckOutProvider>(create: (_)=>CheckOutProvider()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: primaryColor,
            scaffoldBackgroundColor: scaffoldBackgroundColor),
        title: 'Khapa Shapa',
        home: const SignInScreen(),
      ),
    );
  }
}

