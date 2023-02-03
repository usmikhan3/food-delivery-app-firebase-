import 'package:flutter/material.dart';
import 'package:khapa_shapa/models/user_model.dart';
import 'package:khapa_shapa/utils/colors.dart';


class MyProfileScreen extends StatefulWidget {
   MyProfileScreen({Key? key, required this.userData}) : super(key: key);

  UserModel userData;

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  Widget profileListTile({required IconData icon, required String title}){
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "My Profile",
          style: TextStyle(color: textColor,fontSize: 18,),
        ),
      ),

      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                color: primaryColor,
              ),
              Expanded(
                child: Container(

                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                    )
                  ),

                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 250,
                            height: 80,
                            padding: EdgeInsets.only(
                              left: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Text(widget.userData.userName,style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),),

                                    SizedBox(height: 10,),
                                    Text(widget.userData.userEmail,style: TextStyle(
                                      fontSize: 14,
                                      color: textColor,
                                    ),),
                                  ],
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: primaryColor,
                                  child: CircleAvatar(
                                    radius: 12,
                                    child: Icon(Icons.edit,color: primaryColor,size: 18,),
                                    backgroundColor: scaffoldBackgroundColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),

                      profileListTile(icon: Icons.shop_2_outlined,title:"My Orders"),
                      profileListTile(icon: Icons.location_on,title:"My Delivery Address"),
                      profileListTile(icon: Icons.person_outline,title:"Refer a friend"),
                      profileListTile(icon: Icons.file_copy_outlined,title:"Terms & condition"),
                      profileListTile(icon: Icons.policy_outlined,title:"Privacy Outlined"),
                      profileListTile(icon: Icons.add_chart_outlined,title:"About"),
                      profileListTile(icon: Icons.exit_to_app_outlined,title:"Log Out"),
                    ],
                  ),
                ),


              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 40,left: 30),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: scaffoldBackgroundColor,
                backgroundImage: NetworkImage(
                  widget.userData.userImage,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
