import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/MultilineTextFormField.dart';
import 'package:flutter_ebook/Components/MyTextFormField.dart';
import 'package:flutter_ebook/Config/Colors.dart';
import 'package:flutter_ebook/Controller/BookController.dart';
import 'package:flutter_ebook/Controller/ImageController.dart';
import 'package:flutter_ebook/Controller/PdfController.dart';
import 'package:get/get.dart';

import '../../Models/bookmodel.dart';
import '../../Services/CloudinaryService.dart';
import '../../Components/BackButton.dart';

class AddNewBookPage extends StatefulWidget {
  final BookModel? editBook;
  const AddNewBookPage({super.key, this.editBook});

  @override
  State<AddNewBookPage> createState() => _AddNewBookPageState();
}

class _AddNewBookPageState extends State<AddNewBookPage> {
  final BookController bookController = Get.put(BookController());
  final ImageController imageController = Get.put(ImageController());
  final PdfController pdfController = Get.put(PdfController());

  String selectedCategory = 'Fiction';

  final List<String> categories = [
    'Fiction',
    'Non-Fiction',
    'Science',
    'History',
    'Technology',
    'Biography',
    'Fantasy',
    'Other',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.editBook != null) {
      final book = widget.editBook!;
      bookController.title.text = book.title ?? '';
      bookController.des.text = book.description ?? '';
      bookController.author.text = book.author ?? '';
      bookController.aboutAuth.text = book.aboutAuthor ?? '';
      bookController.price.text = book.price?.toString() ?? '';
      bookController.pages.text = book.pages?.toString() ?? '';
      bookController.language.text = book.language ?? '';
      bookController.audioLen.text = book.audioLen ?? '';
      bookController.rating.text = book.rating ?? '';
      selectedCategory = book.category ?? 'Fiction';

      imageController.imageUrl.value = book.imageUrl ?? '';
      imageController.imagePublicId.value = book.imagePublicId ?? '';

      pdfController.pdfUrl.value = book.pdfUrl ?? '';
      pdfController.pdfPublicId.value = book.pdfPublicId ?? '';
    }
  }

  Future<void> _pickImage() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      imageController.isUploading.value = true;

      final uploadResponse = await CloudinaryService.uploadFileWithResponse(file);
      imageController.isUploading.value = false;

      if (uploadResponse != null) {
        imageController.imageUrl.value = uploadResponse['secure_url'];
        imageController.imagePublicId.value = uploadResponse['public_id'];
      } else {
        Get.snackbar("Error", "Image upload failed");
      }
    }
  }

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      pdfController.isUploading.value = true;

      final uploadResponse = await CloudinaryService.uploadFileWithResponse(file);
      pdfController.isUploading.value = false;

      if (uploadResponse != null) {
        pdfController.pdfUrl.value = uploadResponse['secure_url'];
        pdfController.pdfPublicId.value = uploadResponse['public_id'];
      } else {
        Get.snackbar("Error", "PDF upload failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.editBook != null;

    return Scaffold(
      body: Obx(
            () => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
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
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MyBackButton(),
                                  Text(
                                    isEditing ? "Edit Book" : "Add New Book",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                      color: Theme.of(context).colorScheme.background,
                                    ),
                                  ),
                                  const SizedBox(width: 70),
                                ],
                              ),
                              const SizedBox(height: 60),
                              GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  height: 190,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context).colorScheme.background,
                                    image: imageController.imageUrl.isNotEmpty
                                        ? DecorationImage(
                                      image: NetworkImage(imageController.imageUrl.value),
                                      fit: BoxFit.cover,
                                    )
                                        : null,
                                  ),
                                  child: imageController.imageUrl.isEmpty
                                      ? const Icon(Icons.add)
                                      : null,
                                ),
                              ),
                              if (imageController.isUploading.value)
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: CircularProgressIndicator(),
                                ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CATEGORY DROPDOWN ADDED HERE
                        Text(
                          "Category",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: selectedCategory,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                          items: categories
                              .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedCategory = value;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: _pickPdf,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: pdfController.pdfUrl.value.isNotEmpty
                                        ? Colors.green
                                        : Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.upload_file, color: Colors.white),
                                      SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          "Book PDF",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.audio_file, color: Colors.white),
                                    SizedBox(width: 6),
                                    Flexible(
                                      child: Text(
                                        "Book Audio",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        MyTextFormField(
                          hintText: "Book title",
                          icon: Icons.book,
                          controller: bookController.title,
                        ),
                        const SizedBox(height: 10),
                        MultiLineTextFormField(
                          hintText: "Book Description",
                          controller: bookController.des,
                        ),
                        const SizedBox(height: 10),
                        MyTextFormField(
                          hintText: "Author Name",
                          icon: Icons.person,
                          controller: bookController.author,
                        ),
                        const SizedBox(height: 10),
                        MyTextFormField(
                          hintText: "About Author",
                          icon: Icons.person,
                          controller: bookController.aboutAuth,
                        ),
                        const SizedBox(height: 10),
                        MyTextFormField(
                          icon: Icons.star,
                          controller: bookController.rating,
                          hintText: 'Rating (e.g., 4.5)',
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextFormField(
                                hintText: "Price",
                                icon: Icons.currency_rupee,
                                controller: bookController.price,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: MyTextFormField(
                                hintText: "Pages",
                                icon: Icons.book,
                                controller: bookController.pages,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextFormField(
                                hintText: "Language",
                                icon: Icons.language,
                                controller: bookController.language,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: MyTextFormField(
                                hintText: "Audio Len",
                                icon: Icons.audiotrack,
                                controller: bookController.audioLen,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  bookController.clearAll();
                                  imageController.imageUrl.value = '';
                                  imageController.imagePublicId.value = '';
                                  pdfController.pdfUrl.value = '';
                                  pdfController.pdfPublicId.value = '';
                                  setState(() {
                                    selectedCategory = 'Fiction';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.cancel, color: Theme.of(context).colorScheme.primary),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Cancel",
                                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: GestureDetector(
                                onTap: () async {
                                  if (imageController.imageUrl.value.isEmpty ||
                                      pdfController.pdfUrl.value.isEmpty) {
                                    Get.snackbar("Error", "Please upload both image and PDF");
                                    return;
                                  }

                                  try {
                                    final userId = FirebaseAuth.instance.currentUser!.uid;
                                    final timestamp = FieldValue.serverTimestamp();

                                    if (isEditing) {
                                      await FirebaseFirestore.instance
                                          .collection('books')
                                          .doc(widget.editBook!.id)
                                          .update({
                                        'title': bookController.title.text.trim(),
                                        'description': bookController.des.text.trim(),
                                        'author': bookController.author.text.trim(),
                                        'aboutAuthor': bookController.aboutAuth.text.trim(),
                                        'price': int.tryParse(bookController.price.text.trim()) ?? 0,
                                        'pages': int.tryParse(bookController.pages.text.trim()) ?? 0,
                                        'language': bookController.language.text.trim(),
                                        'audioLen': bookController.audioLen.text.trim(),
                                        'rating': double.tryParse(bookController.rating.text.trim()) ?? 0,
                                        'imageUrl': imageController.imageUrl.value,
                                        'imagePublicId': imageController.imagePublicId.value,
                                        'pdfUrl': pdfController.pdfUrl.value,
                                        'pdfPublicId': pdfController.pdfPublicId.value,
                                        'timestamp': timestamp,
                                        'category': selectedCategory,
                                        'uid': userId,
                                      });
                                      Get.snackbar("Success", "Book updated successfully");
                                    } else {
                                      await FirebaseFirestore.instance.collection('books').add({
                                        'title': bookController.title.text.trim(),
                                        'description': bookController.des.text.trim(),
                                        'author': bookController.author.text.trim(),
                                        'aboutAuthor': bookController.aboutAuth.text.trim(),
                                        'price': int.tryParse(bookController.price.text.trim()) ?? 0,
                                        'pages': int.tryParse(bookController.pages.text.trim()) ?? 0,
                                        'language': bookController.language.text.trim(),
                                        'audioLen': bookController.audioLen.text.trim(),
                                        'rating': double.tryParse(bookController.rating.text.trim()) ?? 0,
                                        'imageUrl': imageController.imageUrl.value,
                                        'imagePublicId': imageController.imagePublicId.value,
                                        'pdfUrl': pdfController.pdfUrl.value,
                                        'pdfPublicId': pdfController.pdfPublicId.value,
                                        'timestamp': timestamp,
                                        'category': selectedCategory,
                                        'uid': userId,
                                      });
                                      Get.snackbar("Success", "Book uploaded successfully");
                                    }

                                    bookController.clearAll();
                                    imageController.imageUrl.value = '';
                                    imageController.imagePublicId.value = '';
                                    pdfController.pdfUrl.value = '';
                                    pdfController.pdfPublicId.value = '';
                                    setState(() {
                                      selectedCategory = 'Fiction';
                                    });

                                    Get.back();
                                  } catch (e) {
                                    Get.snackbar("Error", "Failed: $e");
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      isEditing ? "Update" : "Upload",
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
