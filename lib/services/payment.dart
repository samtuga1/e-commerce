import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Payment {
  static Future<void> initPayment(
      {required String email,
      required String amount,
      required BuildContext context}) async {
    try {
      // CREATE A PAYMENT INTENT ON THE SERVER
      final response = await http.post(
          Uri.parse(
              'https://us-central1-e-commerce-a70a6.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': email,
            'amount': amount,
          });
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      // INITIALIZE PAYMENT SHEET
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          merchantDisplayName: 'Tuga shop',
          customerId: jsonResponse['customer'],
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment was successful'),
        ),
      );
    } on StripeException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occured, ${error.error.localizedMessage}'),
        ),
      );
      log(error.error.localizedMessage.toString());
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occured, $error'),
        ),
      );
      log(error.toString());
    }
  }
}
