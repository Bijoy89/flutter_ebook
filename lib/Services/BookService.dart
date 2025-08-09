import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/bookmodel.dart';

class BookService {
  final CollectionReference _booksCollection =
  FirebaseFirestore.instance.collection('books');

  // For admin: get all books
  Stream<List<BookModel>> getAllBooksStream() {
    return _booksCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => BookModel.fromJson(
        doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }

  // For user: get all books (assuming all books are visible)
  Stream<List<BookModel>> getBooksStream() {
    return getAllBooksStream();
  }

  // Fetch books by a list of book IDs (used for readBooks)
  Future<List<BookModel>> getBooksByIds(List<String> bookIds) async {
    if (bookIds.isEmpty) return [];

    // Firestore limits whereIn to max 10 elements, so chunk if needed
    const chunkSize = 10;
    List<BookModel> results = [];

    for (var i = 0; i < bookIds.length; i += chunkSize) {
      final chunk = bookIds.sublist(
          i, i + chunkSize > bookIds.length ? bookIds.length : i + chunkSize);

      final snapshot = await _booksCollection
          .where(FieldPath.documentId, whereIn: chunk)
          .get();

      results.addAll(snapshot.docs
          .map((doc) =>
          BookModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList());
    }

    return results;
  }

  // Get books uploaded by a specific user (uploaderId)
  Stream<List<BookModel>> getUserUploadedBooks(String userId) {
    return _booksCollection
        .where('uploaderId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => BookModel.fromJson(
        doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }

  // Delete book by ID
  Future<void> deleteBook(String bookId) async {
    await _booksCollection.doc(bookId).delete();
  }

  // Update book document
  Future<void> updateBook(BookModel book) async {
    await _booksCollection.doc(book.id).update(book.toJson());
  }
}
