import 'package:flutter/material.dart';
import 'package:khapa_shapa/models/delivery_address_model.dart';
import 'package:khapa_shapa/providers/check_out_provider.dart';
import 'package:khapa_shapa/utils/colors.dart';
import 'package:khapa_shapa/views/check_out/add_delivery_address/add_deliver_address_screen.dart';

import 'package:khapa_shapa/views/check_out/deilvery_details/single_delivery_item.dart';
import 'package:khapa_shapa/views/check_out/payment_summary/payment_summary.dart';
import 'package:provider/provider.dart';

class DeliveryDetailScreen extends StatefulWidget {


  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  bool isAddress = false;

  DeliveryAddressModel? value;

  List<Widget> addressList = [
    // SingleDeliveryItem(
    //   title: "Usman Khan",
    //   address: "Saadi Town",
    //   number: "+923092023003",
    //   addressType: "Home",
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    CheckOutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Delivery Details"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddDeliveryAddress(

              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child:deliveryAddressProvider.getDeliveryAddressList.isEmpty ? Text("Add new Address") : Text("Payment Summary"),
          /*deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Text("Add new Address")
              :
          Text("Payment Summary"),*/
          onPressed: () {

            deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddDeliveryAddress(),
              ),
            )
                : Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PaymentSummary(
                deliverAddressList:value! ,
                ),
              ),
            );
          },
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Deliver To"),
          ),
          Divider(
            height: 1,
          ),
          deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Center(
            child: Container(
              child: Center(
                child: Text("No delivery address is set yet"),
              ),
            ),
          )
              : Column(
            children: deliveryAddressProvider.getDeliveryAddressList
                .map<Widget>((e) {
              setState(() {
                value  = e;
              });
              return SingleDeliveryItem(
                address:
                "${e.area},${e.street},${e.city}, pin code ${e.pinCode}",
                title: "${e.firstName} ${e.lastName}",
                number: e.mobileNo.toString(),
                addressType: e.addressType == "AddressTypes.Home"
                    ? "Home"
                    : e.addressType == "AddressTypes.Other"
                    ? "Other"
                    : "Work",
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

