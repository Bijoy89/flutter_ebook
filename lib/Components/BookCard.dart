import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String coverUrl;
  final String title;
  final VoidCallback onTap;

  const BookCard({
    super.key,
    required this.coverUrl,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 120,
          child: Column(
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
                  child: coverUrl.isNotEmpty
                      ? Image.network(
                    coverUrl,
                    width: 120,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 120,
                        height: 180,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image, size: 40),
                      );
                    },
                  )
                      : Container(
                    width: 120,
                    height: 180,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image_not_supported, size: 40),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: theme.textTheme.bodyMedium,
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
