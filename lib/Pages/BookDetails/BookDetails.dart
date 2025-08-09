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

  @override
  void initState() {
    super.initState();
    controller = Get.put(BookController());
    _initSubscription();
  }

  void _initSubscription() async {
    final role = widget.role.toLowerCase().trim();
    print("Checking subscription for role: $role");
    if (role == 'admin') {
      print("Role is admin, setting isSubscribed = true");
      setState(() => isSubscribed = true);
      return;
    }

    final uid = FirebaseAuth.instance.currentUser!.uid;
    print("Fetching subscription status for user: $uid");
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final subscribed = doc['isSubscribed'] ?? false;
      print("Subscription status from Firestore: $subscribed");
      setState(() {
        isSubscribed = subscribed;
      });
    } catch (e) {
      print("Error fetching subscription: $e");
      setState(() {
        isSubscribed = false; // fallback to false if error
      });
    }
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

  void _confirmDelete(BookController controller, BookModel book, BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Book"),
        content: const Text("Are you sure you want to delete this book?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              try {
                await controller.deleteBook(book.id ?? '');
                Get.back(); // Go back to previous list or page
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Book deleted successfully")),
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
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final readRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
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
      // still loading subscription status
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final role = widget.role.toLowerCase().trim();

    print("Rendering BookDetails. Role: $role, isSubscribed: $isSubscribed");

    Widget actionWidget;
    if (role == 'user' && !isSubscribed!) {
      actionWidget = ElevatedButton(
        onPressed: () {
          Get.dialog(const SubscriptionDialog()).then((_) => _initSubscription());
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
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About Book", style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text(widget.book.description ?? '', style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 20),
                  Text("About Author", style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text(widget.book.aboutAuthor ?? '', style: Theme.of(context).textTheme.labelMedium),
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
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Theme.of(context).colorScheme.background,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _confirmDelete(controller, widget.book, context),
                            icon: const Icon(Icons.delete),
                            label: const Text("Delete"),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
