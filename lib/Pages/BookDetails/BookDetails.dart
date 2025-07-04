import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/BackButton.dart';
import 'package:flutter_ebook/Pages/BookDetails/BookActionButton.dart';
import 'package:flutter_ebook/Pages/BookDetails/HeaderWidget.dart';
import 'package:get/get.dart';
import '../../Config/Colors.dart';
import '../../Controller/BookController.dart';
import '../../Models/bookmodel.dart';
import '../AddNewBook/AddNewBook.dart';

class BookDetails extends StatelessWidget {
  final BookModel book;
  const BookDetails({super.key, required this.book});

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

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: primaryColor,
              child: HeaderWidget(
                coverurl: book.imageUrl ?? '',
                title: book.title ?? 'No Title',
                author: book.author ?? 'Unknown Author',
                description: book.description ?? '',
                rating: book.rating ?? '0.0',
                pages: book.pages?.toString() ?? '0',
                language: book.language ?? 'N/A',
                audioLen: book.audioLen ?? '0',
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
                  Text(book.description ?? '', style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 20),
                  Text("About Author", style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text(book.aboutAuthor ?? '', style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 30),
                  BookActionButton(bookUrl: book.bookurl ?? ''),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _editBook(controller, book),
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
                          onPressed: () => _confirmDelete(controller, book, context),
                          icon: const Icon(Icons.delete),
                          label: const Text("Delete"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        ),
                      ),
                    ],
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
