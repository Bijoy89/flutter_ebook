import 'package:flutter/material.dart';
import 'package:flutter_ebook/Pages/ProfilePage/ProfilePage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Config/Colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset("Assets/Icons/dashboard.svg"),

        Text(
          "Readify",
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.background,
          ),
        ),

        InkWell(
          onTap: () {
            Get.to(ProfilePage());// Navigate to profile page or perform any action
          },
          child: CircleAvatar(
            backgroundColor: Theme.of(
              context,
            ).colorScheme.background,
            child: const Text(
              "N",
              style: TextStyle(
                  color: primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
