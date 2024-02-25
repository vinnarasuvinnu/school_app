import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:core';
//import 'package:whatsapp/whatsapp.dart';
//google cal package
//apple cal package
// display the creators name as in teachers name

//paymet is not working ..require help to fix it

class ProductInfo extends StatefulWidget {
  final Map<String, dynamic> data_info;
  const ProductInfo({Key? key, required this.data_info}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}
/* WhatsApp whatsapp = WhatsApp();
  int phoneNumber = 910000000000;*/
class _ProductInfoState extends State<ProductInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.data_info);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");

   /* 
        print(await whatsapp.messagesText(
          from: teacher phone number
          to: (payment confirmed)studnentphoneNumber,
          message: "hi (user name) you have registered to (class name) 
                    you will have classes from (start date-end date) using meeting link(link),
          previewUrl: true,
       
          );
        snack bar with google calendar or apple calendar 
        select one 
        add (calss name) (date) ( time )(and class link) to calnedar with reminder notification  
    */
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data_info['name']),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              children: [
                
                (widget.data_info['imageUrl'] != null &&
                        widget.data_info['imageUrl'] != "")
                    ? Image.network(
                        widget.data_info['imageUrl'],
                        fit: BoxFit.fill,
                      )
                    : Container(),
                    
                    
                    Text(widget.data_info['description'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20)),
                   Text(widget.data_info['price'].toString()),
                   ElevatedButton(
                    onPressed: () {
                      Razorpay razorpay = Razorpay();
                      num rupeeprice = int.parse(widget.data_info['price']) * 100;

                      var options = {
                        'key': 'rzp_test_HD32ZvVb1l91ft',// your key,but where will payment be done, 
                                                              //if done to your account i require login details or access
                        'amount': rupeeprice,//error here, help to convert paie into rupee part
                        'name': widget.data_info['name'],//course name
                        'retry': {'enabled': true, 'max_count': 1},
                        'send_sms_hash': true,
                        'prefill': {
                          'contact': '8888888888',
                          'email': 'test@razorpay.com'
                        },
                      };
                      razorpay.on(
                          Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                          handlePaymentSuccessResponse);
                      razorpay.open(options);
                    },
                    child: const Text("Buy now")
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
