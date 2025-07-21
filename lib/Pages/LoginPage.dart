import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/PrimaryButton.dart';
import 'package:flutter_ebook/Pages/HomePage/Homepage.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Image.asset("Assets/Images/book.png", height: 120),
              const SizedBox(height: 20),
              Text(
                "Welcome Back!",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Log in to continue reading",
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 30),

              PrimaryButton(
                btnName: "LOGIN",
                onTap: () {
                  // Navigate to HomePage for now (no backend yet)
                  Get.offAll(() => HomePage());
                },
              ),
              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  // Navigate back to RegistrationPage
                  Get.back();
                },
                child: const Text("Don't have an account? Register"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
