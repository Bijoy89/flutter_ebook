import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/BookCard.dart';
import 'package:flutter_ebook/Components/BookTile.dart';
import 'package:flutter_ebook/Config/Colors.dart';
import 'package:flutter_ebook/Pages/HomePage/Widgets/AppBar.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  final List<String> categories = [
    'All',
    'Fiction',
    'Non-Fiction',
    'Science',
    'History',
    'Technology',
    'Biography',
    'Fantasy',
  ];
  String searchText = '';
  String pendingSearchText = ''; // to hold input while typing

  String selectedCategory = 'All';

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserSubscription();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUserSubscription() async {
    userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = await bookService.usersCollection.doc(userId).get();

    final data = userDoc.data() as Map<String, dynamic>?;

    setState(() {
      isSubscribed = data?['isSubscribed'] ?? false;
    });
  }

  Future<void> _markBookAsRead(String bookId) async {
    if (userId.isEmpty) return;
    final userRef = bookService.usersCollection.doc(userId);
    await userRef.set({
      'readBooks': FieldValue.arrayUnion([bookId])
    }, SetOptions(merge: true));
  }

  void _onBookTap(BookModel book) {
    final normalizedRole = widget.role.toLowerCase().trim();

    if (normalizedRole == 'admin') {
      Get.to(() => BookDetails(book: book, role: 'admin'));
      return;
    }

    if (normalizedRole == 'user') {
      if (isSubscribed) {
        _markBookAsRead(book.id ?? '');
        Get.to(() => BookDetails(book: book, role: 'user'));
      } else {
        showDialog(
          context: context,
          builder: (_) => const SubscriptionDialog(),
        ).then((_) => _loadUserSubscription());
      }
      return;
    }

    // Fallback
    showDialog(
      context: context,
      builder: (_) => const SubscriptionDialog(),
    ).then((_) => _loadUserSubscription());
  }

  // Just update the variable; NO setState here
  void _onSearchChanged(String text) {
    pendingSearchText = text;
  }

  // Update the search and trigger rebuild only on submit
  void _onSearchSubmitted(String text) {
    setState(() {
      searchText = pendingSearchText.trim();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      pendingSearchText = '';
      searchText = '';
      selectedCategory = 'All';
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final normalizedRole = widget.role.toLowerCase().trim();

    Stream<List<BookModel>> booksStream =
    bookService.searchBooksStream(searchText, selectedCategory);

    return Scaffold(
      body: StreamBuilder<List<BookModel>>(
        stream: booksStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.clear, color: theme.colorScheme.primary),
                      onPressed: _clearSearch,
                      tooltip: 'Clear Search',
                    ),
                    const SizedBox(height: 30),
                    Center(child: Text("No books found.")),
                  ],
                ),
              ),
            );
          }

          final books = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  color: theme.colorScheme.primary,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const HomeAppBar(),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          Text(
                            "Welcome to Readify!",
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
                      TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        onSubmitted: _onSearchSubmitted,
                        decoration: InputDecoration(
                          hintText: 'Search by title or author',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: pendingSearchText.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: _clearSearch,
                          )
                              : null,
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 10),
                          itemBuilder: (context, index) {
                            final cat = categories[index];
                            final isSelected = cat == selectedCategory;

                            return GestureDetector(
                              onTap: () => _onCategorySelected(cat),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? theme.colorScheme.secondary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: theme.colorScheme.secondary,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    cat,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : theme.colorScheme.secondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
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
                            showEditDelete: normalizedRole == 'admin',
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
