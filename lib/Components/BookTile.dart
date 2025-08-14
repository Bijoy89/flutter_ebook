import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookTile extends StatelessWidget {
  final String coverUrl;
  final String title;
  final String author;
  final int price;
  final String rating;
  final int totalRatings; // rename to lowerCamelCase
  final VoidCallback onTap;
  final bool showEditDelete;

  const BookTile({
    super.key,
    required this.coverUrl,
    required this.title,
    required this.author,
    required this.price,
    required this.rating,
    required this.onTap,
    required this.totalRatings,
    this.showEditDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    coverUrl,
                    width: 100,
                    height: 140,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100,
                        height: 140,
                        color: Colors.grey[300],
                        child: Icon(Icons.broken_image, color: Colors.grey[700]),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "By: $author",
                      style: theme.textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Price: \$${price.toString()}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SvgPicture.asset("Assets/Icons/star.svg"), // Check asset path casing
                        const SizedBox(width: 4),
                        Text(
                          rating,
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            "($totalRatings Ratings)",
                            style: theme.textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // If you want to add Edit/Delete buttons later for showEditDelete == true, add here.
            ],
          ),
        ),
      ),
    );
  }
}
