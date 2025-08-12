import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/bookmodel.dart';

class BookService {
  final CollectionReference _booksCollection =
  FirebaseFirestore.instance.collection('books');
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');

  // Add public getter for users collection
  CollectionReference get usersCollection => _usersCollection;

  // For admin: get all books
  Stream<List<BookModel>> getAllBooksStream() {
    return _booksCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) =>
        BookModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }

  // For user: get all books (assuming all books are visible)
  Stream<List<BookModel>> getBooksStream() {
    return getAllBooksStream();
  }

  // Search books by title or author (case-insensitive)
  Stream<List<BookModel>> searchBooksStream(String search, String? category) {
    if (search.isEmpty && (category == null || category == 'All')) {
      return getAllBooksStream();
    }

    Query query = _booksCollection.orderBy('timestamp', descending: true);
    if (category != null && category != 'All') {
      query = query.where('category', isEqualTo: category);
      print('Filtering category: $category');
    }

    return query.snapshots().map((snapshot) {
      print('Docs count for category "$category": ${snapshot.docs.length}');
      final lowerSearch = search.toLowerCase();
      return snapshot.docs
          .map((doc) =>
          BookModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .where((book) {
        final title = book.title?.toLowerCase() ?? '';
        final author = book.author?.toLowerCase() ?? '';
        return title.contains(lowerSearch) || author.contains(lowerSearch);
      }).toList();
    });
  }

  // Fetch books by a list of book IDs (used for readBooks/favorites)
  Future<List<BookModel>> getBooksByIds(List<String> bookIds) async {
    if (bookIds.isEmpty) return [];

    const chunkSize = 10;
    List<BookModel> results = [];

    for (var i = 0; i < bookIds.length; i += chunkSize) {
      final chunk = bookIds.sublist(
          i, i + chunkSize > bookIds.length ? bookIds.length : i + chunkSize);

      final snapshot =
      await _booksCollection.where(FieldPath.documentId, whereIn: chunk).get();

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
        .map((doc) =>
        BookModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
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

  // Favorites related methods:

  // Stream favorite books for user
  Stream<List<BookModel>> getFavoriteBooksStream(String userId) {
    final favRef = _usersCollection.doc(userId).collection('favorites');
    return favRef.snapshots().asyncMap((snap) async {
      final favBookIds = snap.docs.map((d) => d.id).toList();
      return getBooksByIds(favBookIds);
    });
  }

  // Check if book is favorite for user
  Future<bool> isFavorite(String userId, String bookId) async {
    final doc =
    await _usersCollection.doc(userId).collection('favorites').doc(bookId).get();
    return doc.exists;
  }

  // Add book to favorites
  Future<void> addFavorite(String userId, BookModel book) async {
    final favRef = _usersCollection.doc(userId).collection('favorites').doc(book.id);
    await favRef.set({
      'title': book.title,
      'author': book.author,
      'imageUrl': book.imageUrl,
      'pdfUrl': book.pdfUrl,
      'addedAt': DateTime.now().toIso8601String(),
    });
  }

  // Remove book from favorites
  Future<void> removeFavorite(String userId, String bookId) async {
    final favRef = _usersCollection.doc(userId).collection('favorites').doc(bookId);
    await favRef.delete();
  }
}
