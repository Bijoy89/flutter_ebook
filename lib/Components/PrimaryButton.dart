import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onTap;
  final bool showGoogleIcon;

  const PrimaryButton({
    super.key,
    required this.btnName,
    required this.onTap,
    this.showGoogleIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showGoogleIcon)
              SvgPicture.asset(
                "Assets/Icons/google.svg",
                height: 24,
                width: 24,
              ),
            if (showGoogleIcon) SizedBox(width: 10),
            Text(
              btnName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
