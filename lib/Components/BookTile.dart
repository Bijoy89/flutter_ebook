import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookTile extends StatelessWidget {
  final String coverUrl;
  final String title;
  final String author;
  final int price;
  final String rating;
  final int TotalRatings;
  const BookTile({
    super.key,
    required this.coverUrl,
    required this.title,
    required this.author,
    required this.price,
    required this.rating,
    required this.TotalRatings,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () {
          // Handle tap for Navigation
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.2),
                      spreadRadius: 2, //shadows spread
                      blurRadius: 8, //Shadow blur
                      offset: Offset(2, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(coverUrl, width: 100),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(height: 4),
                    Text(
                      "By :$author",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      "Price :$price",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),

                    SizedBox(height: 4),

                    Row(
                      children: [
                        SvgPicture.asset("Assets/Icons/star.svg"),
                        Text(
                          rating,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "($TotalRatings Ratings)",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
