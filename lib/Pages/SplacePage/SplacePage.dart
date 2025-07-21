import 'package:flutter/material.dart';
import 'package:flutter_ebook/Controller/SplaceController.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplacePage extends StatelessWidget {
  const SplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    SplaceController splaceController =Get.put(SplaceController());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
      // Using Lottie to display an animation
      child: Lottie.asset("Assets/Animations/Anim1.json")
    ),
    );
  }
}
