import 'package:flutter/material.dart';
import 'package:flutter_ebook/Controller/PdfController.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../Components/BackButton.dart';

class BookPage extends StatefulWidget {
  final String? bookUrl;
  const BookPage({super.key, this.bookUrl});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final PdfController pdfController = Get.put(PdfController());
  final FlutterTts flutterTts = FlutterTts();
  bool isReading = false;

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  List<String> _splitTextIntoChunks(String text, int maxLength) {
    List<String> chunks = [];
    int start = 0;
    while (start < text.length) {
      int end = (start + maxLength < text.length) ? start + maxLength : text.length;
      chunks.add(text.substring(start, end));
      start = end;
    }
    return chunks;
  }

  Future<void> readPdfAsText() async {
    if (isReading) {
      await flutterTts.stop();
      setState(() => isReading = false);
      return;
    }

    final url = widget.bookUrl ?? 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final document = PdfDocument(inputBytes: bytes);

        // extract all text (no page-wise method)
        String fullText = PdfTextExtractor(document).extractText();

        // Basic attempt to remove first two pages:
        // If your PDF separates pages by "\f" (form feed), you can split:
        // (If no page breaks, this may be inaccurate)
        List<String> pages = fullText.split('\f');
        String textToRead = pages.length > 2
            ? pages.sublist(2).join('\n\n') // skip first two pages
            : fullText;

        document.dispose();

        if (textToRead.trim().isEmpty) {
          Get.snackbar("No Text", "PDF has no readable content after first two pages.");
          return;
        }

        setState(() => isReading = true);

        await flutterTts.setLanguage("en-US");
        await flutterTts.setSpeechRate(0.5);
        await flutterTts.setVolume(1.0);
        await flutterTts.setPitch(1.0);

        final chunks = _splitTextIntoChunks(textToRead, 1500);
        for (final chunk in chunks) {
          if (!isReading) break;
          await flutterTts.speak(chunk);
          await flutterTts.awaitSpeakCompletion(true);
        }

        setState(() => isReading = false);
      } else {
        Get.snackbar("Error", "Failed to fetch PDF content.");
      }
    } catch (e) {
      setState(() => isReading = false);
      Get.snackbar("Error", "Failed to read PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final url = widget.bookUrl ?? 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf';

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).colorScheme.background),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Book",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'bookmark_fab',
            onPressed: () {
              pdfController.pdfViewerKey.currentState?.openBookmarkView();
            },
            child: Icon(Icons.bookmark, color: Theme.of(context).colorScheme.background),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'tts_fab',
            onPressed: readPdfAsText,
            child: Icon(
              isReading ? Icons.stop : Icons.volume_up,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
        ],
      ),
      body: SfPdfViewer.network(
        url,
        key: pdfController.pdfViewerKey,
        onDocumentLoadFailed: (details) {
          Get.snackbar("Load Failed", details.description);
        },
      ),
    );
  }
}
