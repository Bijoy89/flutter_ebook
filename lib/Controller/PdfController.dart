import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../Services/CloudinaryService.dart';

class PdfController extends GetxController {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();

  RxString pdfUrl = ''.obs;
  RxString pdfPublicId = ''.obs;  // NEW to track publicId
  RxBool isUploading = false.obs;

  Future<Map<String, dynamic>?> pickAndUploadPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      isUploading.value = true;

      final uploadResponse = await CloudinaryService.uploadFileWithResponse(file);

      isUploading.value = false;

      if (uploadResponse != null) {
        pdfUrl.value = uploadResponse['secure_url'];
        pdfPublicId.value = uploadResponse['public_id'];
        return uploadResponse;
      }
    }
    return null;
  }
}
