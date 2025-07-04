import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Models/bookmodel.dart';

class BookService {
  final CollectionReference _booksCollection =
  FirebaseFirestore.instance.collection('books');

  Stream<List<BookModel>> getBooksStream() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      // User not logged in, return empty stream
      return Stream.value([]);
    }

    return _booksCollection
        .where('uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => BookModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }

  Future<void> deleteBook(String bookId) async {
    await _booksCollection.doc(bookId).delete();
  }

  Future<void> updateBook(BookModel book) async {
    await _booksCollection.doc(book.id).update(book.toJson());
  }
}
