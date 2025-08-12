import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/BackButton.dart';
import 'package:flutter_ebook/Pages/BookDetails/BookActionButton.dart';
import 'package:flutter_ebook/Pages/BookDetails/HeaderWidget.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Config/Colors.dart';
import '../../Controller/BookController.dart';
import '../../Models/bookmodel.dart';
import '../../Services/BookService.dart';
import '../AddNewBook/AddNewBook.dart';
import '../SubscriptionDialog.dart';

class BookDetails extends StatefulWidget {
  final BookModel book;
  final String role; // 'admin' or 'user'

  const BookDetails({super.key, required this.book, required this.role});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  late final BookController controller;
  bool? isSubscribed;
  bool _isFavorite = false;
  final BookService bookService = BookService();
  final String _userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BookController());
    _initSubscription();
    _loadFavoriteStatus();
  }

  void _initSubscription() async {
    final role = widget.role.toLowerCase().trim();
    if (role == 'admin') {
      setState(() => isSubscribed = true);
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(
          _userId).get();
      final subscribed = doc['isSubscribed'] ?? false;
      setState(() {
        isSubscribed = subscribed;
      });
    } catch (e) {
      setState(() {
        isSubscribed = false;
      });
    }
  }

  void _loadFavoriteStatus() async {
    final fav = await bookService.isFavorite(_userId, widget.book.id ?? '');
    setState(() {
      _isFavorite = fav;
    });
  }

  void _toggleFavorite() async {
    if (_isFavorite) {
      await bookService.removeFavorite(_userId, widget.book.id ?? '');
    } else {
      await bookService.addFavorite(_userId, widget.book);
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _editBook(BookController controller, BookModel book) {
    controller.title.text = book.title ?? '';
    controller.des.text = book.description ?? '';
    controller.author.text = book.author ?? '';
    controller.aboutAuth.text = book.aboutAuthor ?? '';
    controller.price.text = book.price?.toString() ?? '';
    controller.pages.text = book.pages?.toString() ?? '';
    controller.language.text = book.language ?? '';
    controller.audioLen.text = book.audioLen ?? '';
    controller.rating.text = book.rating ?? '';
    Get.to(() => AddNewBookPage(editBook: book));
  }

  void _confirmDelete(BookController controller, BookModel book,
      BuildContext context) {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: const Text("Delete Book"),
            content: const Text("Are you sure you want to delete this book?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  try {
                    await controller.deleteBook(book.id ?? '');
                    Get.back();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Book deleted successfully")),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Delete failed: $e")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Delete"),
              ),
            ],
          ),
    );
  }

  void markBookAsRead(BookModel book) async {
    final readRef = FirebaseFirestore.instance
        .collection('users')
        .doc(_userId)
        .collection('readBooks')
        .doc(book.id);

    await readRef.set({
      'title': book.title,
      'author': book.author,
      'imageUrl': book.imageUrl,
      'pdfUrl': book.bookurl,
      'price': book.price,
      'rating': book.rating,
      'numberofRating': book.numberofRating,
      'readAt': DateTime.now().toIso8601String(),
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSubscribed == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final role = widget.role.toLowerCase().trim();

    Widget actionWidget;
    if (role == 'user' && !isSubscribed!) {
      actionWidget = ElevatedButton(
        onPressed: () {
          Get.dialog(const SubscriptionDialog()).then((_) =>
              _initSubscription());
        },
        child: const Text("Subscribe to Read"),
      );
    } else if (role == 'admin' || (role == 'user' && isSubscribed!)) {
      actionWidget = BookActionButton(
        bookUrl: widget.book.bookurl ?? '',
        bookId: widget.book.id ?? '',
        onRead: () => markBookAsRead(widget.book),
      );
    } else {
      actionWidget = const SizedBox.shrink();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: primaryColor,
              child: HeaderWidget(
                coverurl: widget.book.imageUrl ?? '',
                title: widget.book.title ?? 'No Title',
                author: widget.book.author ?? 'Unknown Author',
                description: widget.book.description ?? '',
                rating: widget.book.rating ?? '0.0',
                pages: widget.book.pages?.toString() ?? '0',
                language: widget.book.language ?? 'N/A',
                audioLen: widget.book.audioLen ?? '0',
                isFavorite: _isFavorite,
                onFavoriteToggle: _toggleFavorite,
              ),
            ),
            const SizedBox(height: 10),
            // Removed favorite icon button here

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About Book", style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium),
                  const SizedBox(height: 8),
                  Text(widget.book.description ?? '', style: Theme
                      .of(context)
                      .textTheme
                      .labelMedium),
                  const SizedBox(height: 20),
                  Text("About Author", style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium),
                  const SizedBox(height: 8),
                  Text(widget.book.aboutAuthor ?? '', style: Theme
                      .of(context)
                      .textTheme
                      .labelMedium),
                  const SizedBox(height: 30),

                  actionWidget,

                  const SizedBox(height: 20),
                  if (role == 'admin') ...[
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _editBook(controller, widget.book),
                            icon: const Icon(Icons.edit),
                            label: const Text("Edit"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              foregroundColor: Theme
                                  .of(context)
                                  .colorScheme
                                  .background,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                _confirmDelete(
                                    controller, widget.book, context),
                            icon: const Icon(Icons.delete),
                            label: const Text("Delete"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
