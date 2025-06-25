import 'package:flutter/material.dart';
import 'package:flutter_ebook/Controller/PdfController.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../Components/BackButton.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {

  @override
  Widget build(BuildContext context) {
    PdfController pdfController = Get.put(PdfController());
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
      floatingActionButton:FloatingActionButton(onPressed: (){
        pdfController.pdfViewerKey.currentState?.openBookmarkView();
      },child: Icon(Icons.bookmark,color: Theme.of(context).colorScheme.background,
      ),
      ),
      body:SfPdfViewer.network(
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
        key: pdfController.pdfViewerKey,
      ),
    );
  }
}
