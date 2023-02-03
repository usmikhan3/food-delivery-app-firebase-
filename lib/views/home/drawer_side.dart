import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khapa_shapa/providers/user_provider.dart';
import 'package:khapa_shapa/utils/colors.dart';
import 'package:khapa_shapa/views/auth/sign_in.dart';
import 'package:khapa_shapa/views/cart/cart_screen.dart';
import 'package:khapa_shapa/views/profile/profile_screen.dart';
import 'package:khapa_shapa/views/wishlist/wishlist_screen.dart';


class DrawerSide extends StatefulWidget {
  UserProvider userProvider;
   DrawerSide({Key? key, required this.userProvider}) : super(key: key);

  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  Widget listTileDrawer({required IconData icon,required String title,VoidCallback? onTap}){
    return ListTile(
      onTap: onTap,
      leading: Icon(icon,size: 32,),
      title: Text(title,style: TextStyle(
        color: Colors.black45,
      ),),

    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    var userData  = widget.userProvider.currentUserData;


    void signout() async {
      final GoogleSignIn _googleSignIn = GoogleSignIn();

      _googleSignIn.signOut();
      _googleSignIn.disconnect();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SignInScreen(),
        ),
      );
    }


    return Drawer(

      child: Container(
        height: h,
        color: primaryColor,
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 38,
                      backgroundImage: NetworkImage(
                        userData.userImage,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text("Welcome",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              Text("${userData.userName}"),
                            ],
                          ),
                          Text(
                            userData.userEmail,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            listTileDrawer(title: "Home", icon: Icons.home_outlined),
            listTileDrawer(title: "My Cart", icon: Icons.shopping_cart,
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_)=>CartScreen(),),);
            }),
            listTileDrawer(title: "My Profile", icon: Icons.person_outlined,onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_)=>MyProfileScreen(userData:userData),),);
            }),
            listTileDrawer(title: "Notification", icon: Icons.notifications_outlined),
            listTileDrawer(title: "Rating & Review", icon: Icons.star_border_outlined),
            listTileDrawer(title: "Wishlist", icon: Icons.favorite_border_outlined,
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_)=>WishListScreen(),),);
            }),
            listTileDrawer(title: "Raise a complaint", icon: Icons.copy),
            listTileDrawer(title: "FAQS", icon: Icons.comment,onTap: signout),
            listTileDrawer(title: "Log Out", icon: Icons.exit_to_app_outlined,onTap: signout),

            const Divider(
              thickness: 1,
              color: Colors.black45,
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Contact Support",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                  const SizedBox(height: 10,),
                  Row(
                    children: const[
                      Text("Call us: "),
                      Text("+923092023003",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children:  const[
                      Text("Mail us: "),
                      SizedBox(height: 5,),
                      Text("help@khapashapa.com",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
