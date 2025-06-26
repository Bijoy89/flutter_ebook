import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplacePage extends StatelessWidget {
  const SplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
      // Using Lottie to display an animation
      child: Lottie.asset("Assets/Animations/Anim1.json")
    ),
    );
  }
}
