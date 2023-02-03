import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khapa_shapa/providers/user_provider.dart';
import 'package:khapa_shapa/views/home/home_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final UserProvider _userProvider = UserProvider();

  Future _googleSignUp() async {

    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User? user = (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user!.displayName.toString());



      _userProvider.addUserData(
        currentUser: user,
        userName: user.displayName!,
        userEmail: user.email! ,
        userImage: user.photoURL!,
      );

      return user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }




  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Sign in to continue",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Khapa Shapa",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.green.shade900,
                            offset: const Offset(7, 5),
                            spreadRadius: 5,
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SignInButton(
                    Buttons.Apple,
                    text: "Sign in with Google",
                    onPressed: () {},
                  ),
                  SignInButton(
                    Buttons.Google,
                    text: "Sign in with Google",
                    onPressed: () {
                      _googleSignUp().then(
                        (value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomeScreen(),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "By signing in you are agreeing to our",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Terms & Privacy Policy",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
