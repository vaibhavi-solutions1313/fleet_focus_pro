import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../app/modules/splash/controllers/splash_controller.dart';
import '../constant.dart';
import '../plans_view.dart';

Map<String, dynamic>? paymentIntent;
String paymentIDFound = "";
String packageId = "";
Future<void> makePayment(BuildContext context, String amount, String currency, String planId) async {
  try {
    // int reformattedAmount = int.parse(amount) * 100;
    paymentIntent = await createPaymentIntent(amount, currency);
    log(jsonEncode(paymentIntent));
    var dataDecoded = jsonDecode(jsonEncode(paymentIntent));
    paymentIDFound = dataDecoded['id'];
    packageId = planId;
    //STEP 2: Initialize Payment Sheet
    await Stripe.instance
        .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'], //Gotten from payment intent
            style: ThemeMode.dark,
            merchantDisplayName: 'Jay Vendor',
            customerId: paymentIntent!['customer'],
            setupIntentClientSecret: paymentIntent!['client_secret'],
            customerEphemeralKeySecret: paymentIntent!['ephemeralKey'],
            // returnURL: "https://",
            // billingDetails: const BillingDetails(
            //     name: "Atish Paul",
            //     email: "atish@solutions1313.com",
            //     phone: "8709108594",
            //     address: Address(line1: "abc", line2: "def", city: "jamshedpur", state: "jharkhand", country: "india", postalCode: "831019"),
            // ),
          ),
        )
        .then((value) {});

    //STEP 3: Display Payment sheet
    displayPaymentSheet(context, amount);
  } catch (err) {
    throw Exception(err);
  }
}

displayPaymentSheet(BuildContext context, String amount) async {
  try {
    await Stripe.instance.presentPaymentSheet().then((paymentSheetPaymentOption) async {
      context.loaderOverlay.show();
      print('$packageId$paymentIDFound$amount');
      await subscribePlan(packageId, paymentIDFound, amount).then((value1) async {
        await Get.find<SplashController>().getUser();
        context.loaderOverlay.hide();
        if (value1.statusCode == 200) {
          await Get.find<SplashController>().getUser(); // GET ACTIVE PLANS API
          Future.delayed(const Duration(milliseconds: 3000), () {
            Get.back();
            Get.back();
          });
          showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 100.0,
                        ),
                        SizedBox(height: 10.0),
                        Text("Payment Successful!"),
                      ],
                    ),
                  ));
        }
      }).onError((error, stackTrace) {
        context.loaderOverlay.hide();
      });
      paymentIntent = null;
    }).onError((error, stackTrace) {
      throw Exception(error);
    });
  } on StripeException catch (e) {
    print('Error is:---> $e');
    const AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              Text("Payment Failed"),
            ],
          ),
        ],
      ),
    );
  } catch (e) {
    print('$e');
  }
}

createPaymentIntent(String amount, String currency) async {
  try {
    //Request body
    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
    };

    //Make post request to Stripe
    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {'Authorization': 'Bearer ${Configs.stripeClientSecretKey}', 'Content-Type': 'application/x-www-form-urlencoded'},
      body: body,
    );
    return json.decode(response.body);
  } catch (err) {
    throw Exception(err.toString());
  }
}

calculateAmount(String amount) {
  final calculatedAmout = (int.parse(amount)) * 100;
  return calculatedAmout.toString();
}
