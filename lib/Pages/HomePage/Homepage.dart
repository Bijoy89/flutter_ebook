import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/BookCard.dart';
import 'package:flutter_ebook/Config/Colors.dart';
import 'package:flutter_ebook/Pages/HomePage/Widgets/AppBar.dart';
import 'package:flutter_ebook/Pages/HomePage/Widgets/CategoryWidget.dart';
import 'package:flutter_ebook/Pages/HomePage/Widgets/MyinputTextField.dart';
import 'package:get/get.dart';

import '../../Components/BookTile.dart';
import '../../Models/Data.dart';
import '../../Models/bookmodel.dart';
import '../../Services/BookService.dart';
import '../BookDetails/BookDetails.dart';

class HomePage extends StatelessWidget {
  final BookService bookService = BookService();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<BookModel>>(
        stream: bookService.getBooksStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No books found."));
          }

          final books = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  color: Theme.of(context).colorScheme.primary,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      HomeAppBar(),
                      SizedBox(height: 50),

                      Row(
                        children: [
                          Text(
                            "Hi! Good Morning ",
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.background,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              "Time to read book and enhance your knowledge",
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.background,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      MyInputTextField(),
                      SizedBox(height: 20),

                      Row(
                        children: [
                          Text(
                            "Topics",
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.background,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: categoryData
                              .map(
                                (e) => Categorywidget(
                                  iconPath: e["icon"]!,
                                  categoryName: e["label"]!,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Trending",
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onBackground,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: books
                              .map(
                                (e) => BookCard(
                                  title: e.title ?? '',
                                  coverUrl: e.imageUrl ?? '',
                                  onTap: () {
                                    Get.to(() => BookDetails(book: e));
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),

                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Your Interest",
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                              fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: books
                            .map(
                              (e) => BookTile(
                                coverUrl: e.imageUrl ?? '',
                                title: e.title ?? '',
                                author: e.author ?? '',
                                price: e.price ?? 0,
                                rating: e.rating?.toString() ?? '0',
                                TotalRatings: e.numberofRating ?? 0,
                                ontap: () {
                                  Get.to(() => BookDetails(book: e));
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
