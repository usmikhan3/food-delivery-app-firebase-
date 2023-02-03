import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:khapa_shapa/models/delivery_address_model.dart';
import 'package:khapa_shapa/providers/cart_provider.dart';
import 'package:khapa_shapa/providers/check_out_provider.dart';
import 'package:khapa_shapa/utils/colors.dart';
import 'package:khapa_shapa/utils/constants.dart';
import 'package:khapa_shapa/views/check_out/deilvery_details/single_delivery_item.dart';
import 'package:khapa_shapa/views/check_out/payment_summary/payment_screen.dart';
import 'package:khapa_shapa/views/order_success/order_success_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'order_item.dart';

class PaymentSummary extends StatefulWidget {

  final DeliveryAddressModel deliverAddressList;



  const PaymentSummary({Key? key,required this.deliverAddressList}) : super(key: key);

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

enum AddressTypes {
  Home,
  OnlinePayment,
}

class _PaymentSummaryState extends State<PaymentSummary> {

  var myType = AddressTypes.Home;
  /*Map<String, dynamic>? paymentIntent;


  CartProvider? cartProviderr;





  Future<void> makePayment() async {
    try {
      paymentIntent =
      await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              setupIntentClientSecret: SECRET_KEY,
              paymentIntentClientSecret:
              paymentIntent!['client_secret'],
              //applePay: PaymentSheetApplePay.,
              //googlePay: true,
              //testEnv: true,
              customFlow: true,
              style: ThemeMode.dark,
              // merchantCountryCode: 'US',
              merchantDisplayName: 'usman'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('Payment exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
        //       parameters: PresentPaymentSheetParameters(
        // clientSecret: paymentIntentData!['client_secret'],
        // confirmPayment: true,
        // )
      )
          .then((newValue) {
        print('payment intent' + paymentIntent!['id'].toString());
        print(
            'payment intent' + paymentIntent!['client_secret'].toString());
        print('payment intent' + paymentIntent!['amount'].toString());
        print('payment intent' + paymentIntent.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ' + SECRET_KEY,
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }*/
  @override
  Widget build(BuildContext context) {

    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getReviewCartData();
    double discount = 10;
    double? discountValue;
    double shippingCharge = 50;
    double subTotalPrice = cartProvider.getTotalPrice();
    double total = subTotalPrice + shippingCharge;



    if (subTotalPrice >= 2000) {
      setState(() {
        shippingCharge = 0;

      });
      discountValue = ((subTotalPrice * discount)/100);

      total = subTotalPrice - discountValue ;

    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Payment Summary",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          "Rs ${total}",
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () async{
              // myType == AddressTypes.OnlinePayment
              //     ?await makePayment()
              //     : Container();
              
              Navigator.push(context, MaterialPageRoute(builder: (_)=>OrderSuccess()));
            },
            child: Text(
              "Place Order",
              style: TextStyle(
                color: textColor,
              ),
            ),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SingleDeliveryItem(
                  address:
                  "${widget.deliverAddressList.area},${widget.deliverAddressList.street},${widget.deliverAddressList.city}, pin code ${widget.deliverAddressList.pinCode}",
                  title: "${widget.deliverAddressList.firstName} ${widget.deliverAddressList.lastName}",
                  number: widget.deliverAddressList.mobileNo.toString(),
                  addressType: widget.deliverAddressList.addressType == "AddressTypes.Home"
                      ? "Home"
                      : widget.deliverAddressList.addressType == "AddressTypes.Other"
                      ? "Other"
                      : "Work",
                ),


                ListTile(
                  minVerticalPadding: 5,
                  leading: Text("Note: On Order of Rs 2000 or more there will be 10% Discount and no delivery charges",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600
                    ),
                  ),


                ),

                Divider(),




                ExpansionTile(
                    title:Text("Order Items: ${cartProvider.getReviewCartDataList.length}"),
                  children: cartProvider.getReviewCartDataList.map((e) {
                    return OrderItem(e: e,);
                  }).toList(),
                ),
                Divider(),

                 ListTile(
                  minVerticalPadding: 5,
                  leading: Text("Sub Total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600
                  ),),
                  trailing: Text("\$${subTotalPrice}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                ),

                ListTile(
                  minVerticalPadding: 5,
                  leading: Text("Delivery charge",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600
                    ),),
                  trailing: Text("Rs $shippingCharge",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                ),
               /* ListTile(
                  minVerticalPadding: 5,
                  leading: Text("Discount",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600
                    ),),
                  trailing: Text("Rs 0",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                ),*/
                Divider(),

                const ListTile(
                  minVerticalPadding: 5,
                  leading: Text("Payment Option",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,

                    ),),

                ),
                RadioListTile(
                  value: AddressTypes.Home,
                  groupValue: myType,
                  title: Text("COD"),
                  onChanged: (AddressTypes? value) {
                    setState(() {
                      myType = value!;
                    });
                  },
                  secondary: Icon(
                    Icons.money,
                    color: primaryColor,
                  ),
                ),

                RadioListTile(
                  value: AddressTypes.OnlinePayment,
                  groupValue: myType,
                  title: Text("Online Payment"),
                  onChanged: (AddressTypes? value) {
                    setState(() {
                      myType = value!;
                    },
                    );
                  },
                  secondary: Icon(
                    Icons.online_prediction,
                    color: primaryColor,
                  ),
                ),

              ],
            );
          },
        ),
      ),
    );
  }
}
