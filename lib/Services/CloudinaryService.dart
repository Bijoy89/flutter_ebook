import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  static const String cloudName = "db16bg7fi";
  static const String uploadPreset = "ebook_upload";

  static Future<Map<String, dynamic>?> uploadFileWithResponse(File file) async {
    final uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/auto/upload");

    var request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      final resData = await response.stream.bytesToString();
      return jsonDecode(resData);
    } else {
      print('Upload failed with status: ${response.statusCode}');
      return null;
    }
  }

  static Future<bool> deleteFile({required String publicId}) async {
    print("Deleting Cloudinary file with publicId: $publicId");
    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.106:3000/delete'),  // Use your PC IP address here!
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'publicId': publicId}),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('Cloudinary delete result: $result');
        return result['success'] == true;
      } else {
        print('Cloudinary delete failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Cloudinary delete error: $e');
      return false;
    }
  }
}
