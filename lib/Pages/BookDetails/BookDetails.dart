import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/BackButton.dart';
import 'package:flutter_ebook/Pages/BookDetails/BookActionButton.dart';
import 'package:flutter_ebook/Pages/BookDetails/HeaderWidget.dart';
import 'package:flutter_svg/svg.dart';

import '../../Config/Colors.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              //height: 500,
              color: primaryColor,
              child: Row(children: [Expanded(child: HeaderWidget())]),
            ),
            SizedBox(height: 20),
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
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "War and Peace is a literary work by the Russian author Leo Tolstoy. Set during the Napoleonic Wars, the work comprises both a fictional narrative and chapters in which Tolstoy discusses history and philosophy.",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "About Author",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Count Lev Nikolayevich Tolstoy, usually referred to in English as Leo Tolstoy, was a Russian writer. He is regarded as one of the greatest and most influential authors of all time.",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  BookActionButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
