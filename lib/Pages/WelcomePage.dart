import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/PrimaryButton.dart';
import 'package:flutter_ebook/Controller/AuthController.dart';
import 'package:flutter_ebook/Pages/HomePage/Homepage.dart';
import 'package:get/get.dart';

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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              "Disclaimer",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Readify provides access to books and audiobooks for informational and entertainment purposes only. We do not own or claim rights to third-party content unless stated. All trademarks and content belong to their respective owners.\n\nReadify is not liable for any errors, inaccuracies, or damages resulting from use of the app. By using Readify, you agree to our terms and policies.",
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            const SizedBox(height: 40),
                            PrimaryButton(
                              btnName: "LOGIN WITH GOOGLE",
                              onTap: () {
                                authController.signInWithGoogle();
                                //Get.offAll(HomePage());
                              },
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
