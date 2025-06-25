import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Components/BackButton.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyBackButton(),
            SvgPicture.asset(
              "Assets/Icons/heart.svg",
              color: Theme.of(context).colorScheme.background,
            ),
          ],
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "Assets/Images/9781849908467-jacket-large.jpg",
                width: 170,
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Text(
          "War and Peace",
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        Text(
          "Author: Leo Tolstoy",
          style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "War and Peace is a literary work by the Russian author Leo Tolstoy. Set during the Napoleonic Wars, the work comprises both a fictional narrative and chapters in which Tolstoy discusses history and philosophy.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Rating",
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.background,
                  ),
                ),
                Text(
                  "5.0",
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.background,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Pages",
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.background,
                  ),
                ),
                Text(
                  "203",
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.background,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Language",
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.background,
                  ),
                ),
                Text(
                  "ENG",
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.background,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Audio",
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.background,
                  ),
                ),
                Text(
                  "2 hr",
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.background,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
