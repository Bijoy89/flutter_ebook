import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String coverUrl;
  final String title;
  final VoidCallback onTap;
  const BookCard({super.key, required this.coverUrl, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return           Padding(
      padding:  EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 120,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    spreadRadius: 2,//shadows spread
                    blurRadius: 8, //Shadow blur
                    offset: Offset(2, 2), // changes position of shadow
                  ),
                ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                  coverUrl,
                    width: 120,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
