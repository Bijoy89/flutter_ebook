import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/BackButton.dart';
import 'package:flutter_ebook/Pages/BookDetails/BookActionButton.dart';
import 'package:flutter_ebook/Pages/BookDetails/HeaderWidget.dart';
import 'package:flutter_svg/svg.dart';

import '../../Config/Colors.dart';
import '../../Models/bookmodel.dart';

class BookDetails extends StatelessWidget {
  final BookModel book;
  const BookDetails({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: primaryColor,
              child: Row(
                children: [
                  Expanded(
                    child: HeaderWidget(
                      coverurl: book.coverUrl ?? '',
                      title: book.title ?? 'No Title',
                      author: book.author ?? 'Unknown Author',
                      description: book.description ?? 'No description available.',
                      rating: book.rating ?? '0.0',
                      pages: book.pages?.toString() ?? '0',
                      language: book.language ?? 'N/A',
                      audioLen: book.audioLen ?? '0',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "About Book",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          book.description ?? 'No description available.',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "About Author",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          book.aboutAuthor ?? 'No author information available.',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  BookActionButton(bookUrl: book.bookurl ?? ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
