import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SubscriptionDialog extends StatelessWidget {
  const SubscriptionDialog({super.key});

  Future<void> handlePayment(String method) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'isSubscribed': true,
    });
    Get.back();
    Get.snackbar("Success", "Subscribed using $method");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Subscribe to Read"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Choose your payment method:"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => handlePayment("Card"),
            child: Text("Pay with Card"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => handlePayment("PayPal"),
            child: Text("Pay with PayPal"),
          ),
        ],
      ),
    );
  }
}
