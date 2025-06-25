import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Config/Colors.dart';

class BookActionButton extends StatelessWidget {
  const BookActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return            Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset("Assets/Icons/book.svg"),
              SizedBox(width: 10),
              Text(
                "READ BOOK",
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.background,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          Container(
            width: 3,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Row(
            children: [
              SvgPicture.asset("Assets/Icons/play.svg"),
              SizedBox(width: 10),
              Text(
                "PLAY BOOK",
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.background,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
