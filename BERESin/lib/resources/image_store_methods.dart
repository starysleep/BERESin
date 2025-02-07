import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/models/post.dart';
import 'dart:convert';


 String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';

class ImageStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String cloudinaryUrl = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
  final String uploadPreset = 'file_upload'; // Set this in your Cloudinary settings

  Future<List<String>> imageToStorage(Uint8List file, Uint8List file2) async {
    String id = const Uuid().v1();
    List<String> downloadUrls = [];

    // Upload the first image
    downloadUrls.add(await uploadImageToCloudinary(file, '$id-1'));

    // Upload the second image
    downloadUrls.add(await uploadImageToCloudinary(file2, '$id-2'));

    return downloadUrls; // Return both URLs
  }

  Future<String> uploadImageToCloudinary(Uint8List file, String publicId) async {
    final response = await http.post(
      Uri.parse(cloudinaryUrl),
      body: {
        'file': 'data:image/jpeg;base64,' + base64Encode(file),
        'upload_preset': uploadPreset,
        'public_id': publicId,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['secure_url']; // Return the secure URL of the uploaded image
    } else {
      throw Exception('Failed to upload image to Cloudinary');
    }
  }

  Future<String> uploadPost(String description, Uint8List file, Uint8List file2) async {
    String res = 'Some Error Occurred';
    try {
      if (file == null || file2 == null) {
        return 'No files selected';
      }

      List<String> photoUrls = await imageToStorage(file, file2);
      String postId = const Uuid().v1();

      // Create a post object
      Post post = Post(
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrls[0], // Use the first image URL
        secondPostUrl: photoUrls[1], // Assuming you have a field for the second image
      );

      await _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (err) {
      res = 'Error: ${err.toString()}'; // More informative error message
    }
    return res;
  }
}