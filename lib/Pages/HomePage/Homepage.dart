import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/BookCard.dart';
import 'package:flutter_ebook/Config/Colors.dart';
import 'package:flutter_ebook/Pages/HomePage/Widgets/AppBar.dart';
import 'package:flutter_ebook/Pages/HomePage/Widgets/CategoryWidget.dart';
import 'package:flutter_ebook/Pages/HomePage/Widgets/MyinputTextField.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Components/BookTile.dart';
import '../../Models/Data.dart';
import '../../Models/bookmodel.dart';
import '../../Services/BookService.dart';
import '../BookDetails/BookDetails.dart';
import '../SubscriptionDialog.dart';

class HomePage extends StatefulWidget {
  final String role; // 'admin' or 'user'
  const HomePage({super.key, required this.role});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BookService bookService = BookService();
  bool isSubscribed = false;
  String userId = '';

  @override
  void initState() {
    super.initState();
    _loadUserSubscription();
  }

  Future<void> _loadUserSubscription() async {
    userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

    setState(() {
      isSubscribed = userDoc.data()?['isSubscribed'] ?? false;
    });

    print("Loaded subscription: $isSubscribed");
    print("HomePage role before normalize: ${widget.role}");
  }

  Future<void> _markBookAsRead(String bookId) async {
    if (userId.isEmpty) return;
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    await userRef.set({
      'readBooks': FieldValue.arrayUnion([bookId])
    }, SetOptions(merge: true));
  }

  void _onBookTap(BookModel book) {
    final role = widget.role.toLowerCase().trim();
    print("Book tapped. Role: $role, isSubscribed: $isSubscribed");

    if (role == 'admin') {
      // Admin → directly open
      Get.to(() => BookDetails(book: book, role: 'admin'));
    } else if (role == 'user') {
      if (isSubscribed) {
        _markBookAsRead(book.id ?? '');
        Get.to(() => BookDetails(book: book, role: 'user'));
      } else {
        showDialog(
          context: context,
          builder: (_) => const SubscriptionDialog(),
        ).then((_) => _loadUserSubscription());
      }
    } else {
      print("Unknown role: $role");
      // Fallback behavior - treat as unsubscribed user
      showDialog(
        context: context,
        builder: (_) => const SubscriptionDialog(),
      ).then((_) => _loadUserSubscription());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: StreamBuilder<List<BookModel>>(
        stream: widget.role.toLowerCase().trim() == 'admin'
            ? bookService.getAllBooksStream()
            : bookService.getBooksStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No books found."));
          }

          final books = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  color: theme.colorScheme.primary,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const HomeAppBar(),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          Text(
                            "Hi! Good Morning ",
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.background,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              "Time to read book and enhance your knowledge",
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.background,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const MyInputTextField(),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Topics",
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.background,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Trending",
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onBackground,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: books
                              .map(
                                (e) => BookCard(
                              title: e.title ?? '',
                              coverUrl: e.imageUrl ?? '',
                              onTap: () => _onBookTap(e),
                            ),
                          )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Your Interest",
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onBackground,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: books
                            .map(
                              (e) => BookTile(
                            coverUrl: e.imageUrl ?? '',
                            title: e.title ?? '',
                            author: e.author ?? '',
                            price: e.price ?? 0,
                            rating: e.rating?.toString() ?? '0',
                            totalRatings: e.numberofRating ?? 0,
                            onTap: () => _onBookTap(e),
                            showEditDelete: widget.role.toLowerCase().trim() == 'admin',
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
