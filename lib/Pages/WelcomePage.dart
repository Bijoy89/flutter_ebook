import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/PrimaryButton.dart';
import 'package:flutter_ebook/Controller/AuthController.dart';
import 'package:flutter_ebook/Pages/HomePage/Homepage.dart';
import 'package:get/get.dart';

import 'LoginPage.dart';
import 'RegistrationPage.dart';

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        color: Theme.of(context).colorScheme.primary,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Image.asset(
                              "Assets/Images/book.png",
                              width: 380,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Readify",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .background,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Discover your next favorite book — read or listen anytime, anywhere!",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .background,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            PrimaryButton(
                              btnName: "LOGIN",
                              onTap: () => Get.to(() => LoginPage()),
                              showGoogleIcon: false,
                            ),
                            const SizedBox(height: 20),
                            PrimaryButton(
                              btnName: "REGISTER",
                              onTap: () => Get.to(() => RegistrationPage()),
                              showGoogleIcon: false,
                            ),
                            const SizedBox(height: 20),
                            PrimaryButton(
                              btnName: "LOGIN WITH GOOGLE",
                              onTap: () => authController.signInWithGoogle(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
