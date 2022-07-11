// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:orbital_nus/colors.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> initPaymentSheet(context,
        {required String email, required int amount}) async {
      try {
        final response = await http.post(
            Uri.parse(
                'https://us-central1-pickup-nus.cloudfunctions.net/stripePaymentIntentRequest'),
            body: {
              'email': email,
              'amount': amount.toString(),
            });
        final jsonResponse = jsonDecode(response.body);
        log(jsonResponse.toString());

        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          merchantDisplayName: 'pickup@nus',
          customerId: jsonResponse['customer'],
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
          style: ThemeMode.light,
          testEnv: true,
          merchantCountryCode: 'SG',
        ));
        await Stripe.instance.presentPaymentSheet();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('payment completed')),
        );
      } catch (e) {
        if (e is StripeException) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error from stripe')));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Payment Page'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue)),
              onPressed: () async {
                await initPaymentSheet(context,
                    email: 'example@gmail.com', amount: 100);
              },
              child: const Text(
                'confirm order',
                style: TextStyle(color: Colors.white),
              ))
        ],
      )),
    );
  }
}
