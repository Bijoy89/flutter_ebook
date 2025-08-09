import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/BackButton.dart';
import 'package:flutter_ebook/Components/BookTile.dart';
import 'package:flutter_ebook/Controller/AuthController.dart';
import 'package:flutter_ebook/Pages/AddNewBook/AddNewBook.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Config/Colors.dart';
import '../../Models/bookmodel.dart';
import '../../Services/BookService.dart';
import '../BookDetails/BookDetails.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final BookService bookService = BookService();
  final AuthController authController = Get.put(AuthController());

  late final String uid;
  String role = 'user';
  bool isSubscribed = false;

  List<BookModel> readBooks = [];
  List<BookModel> uploadedBooks = [];

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = doc.data() ?? {};

    role = (data['role'] ?? 'user').toString().toLowerCase().trim();
    isSubscribed = data['isSubscribed'] ?? false;

    final readBookIdsRaw = data['readBooks'] ?? [];
    List<String> readBookIds = [];
    if (readBookIdsRaw is List) {
      readBookIds = List<String>.from(readBookIdsRaw);
    }

    final fetchedReadBooks = await bookService.getBooksByIds(readBookIds);
    // listen to uploaded books stream
    bookService.getUserUploadedBooks(uid).listen((uploaded) {
      setState(() {
        uploadedBooks = uploaded;
        readBooks = fetchedReadBooks;
      });
    });

    setState(() {
      role = role;
      isSubscribed = isSubscribed;
      readBooks = fetchedReadBooks;
    });
  }

  List<BookModel> get combinedBooks {
    if (role == 'admin') {
      // admin shows all books (handled separately in StreamBuilder)
      return [];
    }
    if (isSubscribed) {
      final all = [...readBooks, ...uploadedBooks];
      final seen = <String>{};
      return all.where((b) => seen.add(b.id ?? '')).toList();
    } else {
      // only uploaded books for unsubscribed users
      return uploadedBooks;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (role == 'admin')
          ? FloatingActionButton(
        onPressed: () => Get.to(() => AddNewBookPage()),
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.background),
      )
          : null,
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
                        const SizedBox(height: 20),
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
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 60),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage("Assets/Images/default_user.png"),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          role == 'admin' ? 'Admin' : 'User',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),

                        Text(
                          FirebaseAuth.instance.currentUser?.email ?? '',
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
                        role == 'admin' ? "All Books" : "Your Books",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  role == 'admin'
                      ? StreamBuilder<List<BookModel>>(
                    stream: bookService.getAllBooksStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No books found."));
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
                            totalRatings: e.numberofRating ?? 0,
                            onTap: () => Get.to(() => BookDetails(book: e, role: role)),
                            showEditDelete: true,
                          ),
                        )
                            .toList(),
                      );
                    },
                  )
                      : combinedBooks.isEmpty
                      ? const Center(child: Text("No books found."))
                      : Column(
                    children: combinedBooks
                        .map(
                          (e) => BookTile(
                        coverUrl: e.imageUrl ?? '',
                        title: e.title ?? '',
                        author: e.author ?? '',
                        price: e.price ?? 0,
                        rating: e.rating ?? '0',
                        totalRatings: e.numberofRating ?? 0,
                        onTap: () => Get.to(() => BookDetails(book: e, role: role)),
                        showEditDelete: false,
                      ),
                    )
                        .toList(),
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
