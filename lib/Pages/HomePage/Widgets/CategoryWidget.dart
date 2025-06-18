import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Categorywidget extends StatelessWidget {
  final String iconPath;
  final String categoryName;
  const Categorywidget({super.key, required this.iconPath, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          // Handle tap for Navigation
        },
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.background,),
          child: Row(
            children: [
              SvgPicture.asset(iconPath),
              const  SizedBox(width: 10),
              Text(categoryName),
            ],
          ),
        ),
      ),
    );
  }
}
