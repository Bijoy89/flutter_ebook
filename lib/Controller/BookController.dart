import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Models/bookmodel.dart';
import '../Services/BookService.dart';
import '../Services/CloudinaryService.dart';

class BookController {
  final BookService _bookService = BookService();
  final _booksCollection = FirebaseFirestore.instance.collection('books');

  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController author = TextEditingController();
  TextEditingController aboutAuth = TextEditingController();
  TextEditingController pages = TextEditingController();
  TextEditingController audioLen = TextEditingController();
  TextEditingController language = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController rating = TextEditingController();

  /// Save new book with Cloudinary public IDs
  Future<void> saveBook({
    required String imageUrl,
    required String imagePublicId,
    required String pdfUrl,
    required String pdfPublicId,
  }) async {
    if (title.text.isEmpty ||
        des.text.isEmpty ||
        author.text.isEmpty ||
        imageUrl.isEmpty ||
        pdfUrl.isEmpty ||
        imagePublicId.isEmpty ||
        pdfPublicId.isEmpty) {
      throw Exception('Required fields missing');
    }

    await _booksCollection.add({
      'title': title.text.trim(),
      'description': des.text.trim(),
      'author': author.text.trim(),
      'aboutAuthor': aboutAuth.text.trim(),
      'price': int.tryParse(price.text.trim()) ?? 0,
      'pages': int.tryParse(pages.text.trim()) ?? 0,
      'language': language.text.trim(),
      'audioLength': audioLen.text.trim(),
      'imageUrl': imageUrl,
      'imagePublicId': imagePublicId,
      'pdfUrl': pdfUrl,
      'pdfPublicId': pdfPublicId,
      'rating': double.tryParse(rating.text.trim()) ?? 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  /// Update existing book - update Firestore document
  Future<void> updateBook(BookModel book) async {
    if (book.id == null) {
      throw Exception("Book ID is null");
    }
    await _booksCollection.doc(book.id).update({
      'title': book.title,
      'description': book.description,
      'author': book.author,
      'aboutAuthor': book.aboutAuthor,
      'price': book.price,
      'pages': book.pages,
      'language': book.language,
      'audioLength': book.audioLen,
      'imageUrl': book.imageUrl,
      'imagePublicId': book.imagePublicId,
      'pdfUrl': book.pdfUrl,
      'pdfPublicId': book.pdfPublicId,
      'rating': double.tryParse(book.rating ?? '0') ?? 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  /// Delete book from Firestore and Cloudinary (via backend)
  Future<void> deleteBook(String bookId) async {
    try {
      print("Fetching book for ID: $bookId");
      final doc = await _booksCollection.doc(bookId).get();
      final data = doc.data();

      if (data != null) {
        final pdfPublicId = data['pdfPublicId'] as String?;
        final imagePublicId = data['imagePublicId'] as String?;

        if (pdfPublicId != null && pdfPublicId.isNotEmpty) {
          final pdfDeleted = await CloudinaryService.deleteFile(publicId: pdfPublicId);
          print("PDF deleted from Cloudinary: $pdfDeleted");
          if (!pdfDeleted) throw Exception("Failed to delete PDF from Cloudinary");
        }

        if (imagePublicId != null && imagePublicId.isNotEmpty) {
          final imageDeleted = await CloudinaryService.deleteFile(publicId: imagePublicId);
          print("Image deleted from Cloudinary: $imageDeleted");
          if (!imageDeleted) throw Exception("Failed to delete Image from Cloudinary");
        }

        await _booksCollection.doc(bookId).delete();
        print("Book deleted from Firestore.");
      } else {
        throw Exception("Book data not found");
      }
    } catch (e) {
      print("Error deleting book: $e");
      rethrow; // Let UI handle error display
    }
  }

  void clearAll() {
    title.clear();
    des.clear();
    author.clear();
    aboutAuth.clear();
    pages.clear();
    audioLen.clear();
    language.clear();
    price.clear();
    rating.clear();
  }
}
