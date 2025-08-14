import 'package:flutter/material.dart';

import '../../Components/BackButton.dart';

class HeaderWidget extends StatelessWidget {
  final String coverurl;
  final String title;
  final String author;
  final String description;
  final String rating;
  final String pages;
  final String language;
  final String audioLen;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const HeaderWidget({
    super.key,
    required this.coverurl,
    required this.title,
    required this.author,
    required this.description,
    required this.rating,
    required this.pages,
    required this.language,
    required this.audioLen,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MyBackButton(),
            // Replace SVG heart with favorite icon button (filled/outline)
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.white,
                size: 28,
              ),
              onPressed: onFavoriteToggle,
              tooltip: isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
            ),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: coverurl.isNotEmpty
                  ? Image.network(
                coverurl,
                width: 170,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 170,
                    height: 250,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, size: 50),
                  );
                },
              )
                  : Container(
                width: 170,
                height: 250,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image_not_supported, size: 50),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Text(
          title,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        Text(
          "Author: $author",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _infoColumn("Rating", rating, context),
            _infoColumn("Pages", pages, context),
            _infoColumn("Language", language, context),
            _infoColumn("Audio", audioLen, context),
          ],
        ),
      ],
    );
  }

  Widget _infoColumn(String label, String value, BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ],
    );
  }
}
