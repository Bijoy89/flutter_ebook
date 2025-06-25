import 'package:flutter/material.dart';
import 'package:flutter_ebook/Controller/PdfController.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../Components/BackButton.dart';

class BookPage extends StatelessWidget {
  final String? bookUrl;
  const BookPage({super.key, this.bookUrl});

  @override
  Widget build(BuildContext context) {
    PdfController pdfController = Get.put(PdfController());

    // Use a default PDF URL if none provided
    final url = (bookUrl == null || bookUrl!.isEmpty)
        ? 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'
        : bookUrl!;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).colorScheme.background),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Book Title",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pdfController.pdfViewerKey.currentState?.openBookmarkView();
        },
        child: Icon(
          Icons.bookmark,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      body: SfPdfViewer.network(
        url,
        key: pdfController.pdfViewerKey,
      ),
    );
  }
}
