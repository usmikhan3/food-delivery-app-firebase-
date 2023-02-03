import 'package:flutter/material.dart';
import 'package:khapa_shapa/providers/check_out_provider.dart';
import 'package:khapa_shapa/utils/colors.dart';
import 'package:khapa_shapa/views/check_out/google_map/google_map.dart';
import 'package:khapa_shapa/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddDeliveryAddress extends StatefulWidget {
  const AddDeliveryAddress({Key? key}) : super(key: key);

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  var myType = AddressTypes.Home;

  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Add Delivery Address",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 48,
          child: MaterialButton(
            onPressed: () {
              checkoutProvider.validator(context, myType.toString());
            },
            child: checkoutProvider.isLoading == false
                ? Text(
                    "Add Address",
                    style: TextStyle(
                      color: textColor,
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            CustomTextField(
              labText: "First name",
              keyboardType: TextInputType.name,
              controller: checkoutProvider.firstName,
            ),
            CustomTextField(
              labText: "Last name",
              keyboardType: TextInputType.name,
              controller: checkoutProvider.lastName,
            ),
            CustomTextField(
              labText: "Mobile No",
              keyboardType: TextInputType.phone,
              controller: checkoutProvider.mobileNo,
            ),
            CustomTextField(
              labText: "Alternate Mobile No",
              keyboardType: TextInputType.phone,
              controller: checkoutProvider.alternateNo,
            ),
            CustomTextField(
              labText: "Area",
              keyboardType: TextInputType.streetAddress,
              controller: checkoutProvider.area,
            ),
            CustomTextField(
              labText: "Street",
              keyboardType: TextInputType.streetAddress,
              controller: checkoutProvider.street,
            ),
            CustomTextField(
              labText: "Landmark",
              keyboardType: TextInputType.streetAddress,
              controller: checkoutProvider.landmark,
            ),
            CustomTextField(
              labText: "City",
              keyboardType: TextInputType.streetAddress,
              controller: checkoutProvider.city,
            ),
            CustomTextField(
              labText: "PinCode",
              keyboardType: TextInputType.number,
              controller: checkoutProvider.pinCode,
            ),
            SizedBox(height: 8,),
            Container(
              //height: 47,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Get your location",
                    style:
                        TextStyle(color: Colors.grey.shade700, fontSize: 16),
                  ),
                  checkoutProvider.setLocation == null
                      ? MaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CustomGoogleMap(),
                              ),
                            );
                          },
                          child: Text("Get",style: TextStyle(fontSize: 18),),
                          color: primaryColor,
                        )
                      : Text(
                          "Location is set",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text("Address Type*"),
            ),
            RadioListTile(
              value: AddressTypes.Home,
              groupValue: myType,
              title: Text("Home"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(
                Icons.home,
                color: primaryColor,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Work,
              groupValue: myType,
              title: Text("Work"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(
                Icons.work,
                color: primaryColor,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Other,
              groupValue: myType,
              title: Text("Other"),
              onChanged: (AddressTypes? value) {
                setState(
                  () {
                    myType = value!;
                  },
                );
              },
              secondary: Icon(
                Icons.devices_other,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
