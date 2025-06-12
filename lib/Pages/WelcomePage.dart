import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/PrimaryButton.dart';

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 500,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(
                        ""
                        "Assets/Images/book.png",
                        width: 380,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Readify",
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: Text(
                          "Discover your next favorite book — read or listen anytime, anywhere!",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Disclaimer",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Readify provides access to books and audiobooks for informational and entertainment purposes only. We do not own or claim rights to third-party content unless stated. All trademarks and content belong to their respective owners."
                        "Readify is not liable for any errors, inaccuracies, or damages resulting from use of the app. By using Readify, you agree to our terms and policies.",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(10),
            child: PrimaryButton(
                btnName: "Continue",
                onTap: () {}
            ),
          ),
        ],
      ),
    );
  }
}
