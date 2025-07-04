import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/BackButton.dart';
import 'package:flutter_ebook/Components/BookTile.dart';
import 'package:flutter_ebook/Controller/AuthController.dart';
import 'package:flutter_ebook/Pages/AddNewBook/AddNewBook.dart';
import 'package:get/get.dart';

import '../../Config/Colors.dart';
import '../../Models/bookmodel.dart';
import '../../Services/BookService.dart';
import '../BookDetails/BookDetails.dart';

class ProfilePage extends StatelessWidget {
  final BookService bookService = BookService();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddNewBookPage());
        },
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.background),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyBackButton(),
                            Text(
                              "Profile",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  authController.signOut();
                                },
                                icon: Icon(
                                  Icons.exit_to_app,
                                  color: Theme.of(context).colorScheme.background,
                                ))
                          ],
                        ),
                        SizedBox(height: 60),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                          child: Container(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "Assets/Images/9781849908467-jacket-large.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "John Doe",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                        Text(
                          "John@gmail.com",
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Your Books",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  StreamBuilder<List<BookModel>>(
                    stream: bookService.getBooksStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text("No books uploaded yet."));
                      }
                      final books = snapshot.data!;
                      return Column(
                        children: books
                            .map(
                              (e) => BookTile(
                            coverUrl: e.imageUrl ?? '',
                            title: e.title ?? '',
                            author: e.author ?? '',
                            price: e.price ?? 0,
                            rating: e.rating ?? '0',
                            TotalRatings: e.numberofRating ?? 0,
                            ontap: () {
                              Get.to(() => BookDetails(book: e));
                            },
                          ),
                        )
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
