import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import '../Services/CloudinaryService.dart';

class ImageController extends GetxController {
  RxString imageUrl = ''.obs;       // Holds secure_url
  RxString imagePublicId = ''.obs;  // Holds public_id for deletion
  RxBool isUploading = false.obs;

  // Pick image and upload, saving both url and public id
  Future<void> pickAndUploadImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      isUploading.value = true;

      final uploadResponse = await CloudinaryService.uploadFileWithResponse(file);

      if (uploadResponse != null) {
        imageUrl.value = uploadResponse['secure_url'];
        imagePublicId.value = uploadResponse['public_id'];
      } else {
        imageUrl.value = '';
        imagePublicId.value = '';
      }

      isUploading.value = false;
    }
  }
}
