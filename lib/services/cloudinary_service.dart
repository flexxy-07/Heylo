import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudinaryService {
  static final CloudinaryService _instance = CloudinaryService._internal();

  late final String _cloudName;
  late final String _uploadPreset;

  CloudinaryService._internal() {
    _cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
    _uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? '';

    if (_cloudName.isEmpty || _uploadPreset.isEmpty) {
      throw Exception(
          'Cloudinary credentials not found in .env file. Please add CLOUDINARY_CLOUD_NAME and CLOUDINARY_UPLOAD_PRESET.');
    }
  }

  factory CloudinaryService() {
    return _instance;
  }

  /// Upload image to Cloudinary and return the URL
  /// [file] - The image file to upload
  /// [folder] - Optional folder name in Cloudinary (e.g., 'profile_images')
  /// Returns the Cloudinary URL of the uploaded image
  Future<String> uploadProfileImage({
    required File file,
    String folder = 'heylo/profile_images',
  }) async {
    try {
      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.cloudinary.com/v1_1/$_cloudName/image/upload'),
      );

      // Add fields
      request.fields['upload_preset'] = _uploadPreset;
      request.fields['folder'] = folder;

      // Add file
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
        ),
      );

      // Send request
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);

        // Parse JSON response
        final imageUrl = _extractUrlFromResponse(responseString);
        return imageUrl;
      } else {
        throw Exception(
            'Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error uploading image to Cloudinary: $e');
    }
  }

  /// Update user's profile image (delete old and upload new)
  /// [oldImageUrl] - The URL of the image to delete (optional)
  /// [newImageFile] - The new image file to upload
  Future<String> updateProfileImage({
    String? oldImageUrl,
    required File newImageFile,
  }) async {
    try {
      // Upload new image
      final newImageUrl =
          await uploadProfileImage(file: newImageFile);

      // Delete old image if URL is provided
      if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
        await _deleteImage(oldImageUrl);
      }

      return newImageUrl;
    } catch (e) {
      throw Exception('Error updating profile image: $e');
    }
  }

  /// Delete image from Cloudinary by URL
  Future<void> _deleteImage(String imageUrl) async {
    try {
      // Extract public_id from URL
      final publicId = _extractPublicIdFromUrl(imageUrl);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://api.cloudinary.com/v1_1/$_cloudName/image/destroy'),
      );

      request.fields['public_id'] = publicId;
      request.fields['api_key'] = ''; // Using unsigned preset, so empty api_key
      request.fields['upload_preset'] = _uploadPreset;

      var response = await request.send();

      if (response.statusCode != 200) {
        print('Warning: Failed to delete old image from Cloudinary');
      }
    } catch (e) {
      print('Error deleting image from Cloudinary: $e');
    }
  }

  /// Extract URL from Cloudinary JSON response
  String _extractUrlFromResponse(String responseString) {
    try {
      // Find "secure_url" in the response
      final urlStartIndex = responseString.indexOf('"secure_url":"');
      if (urlStartIndex == -1) {
        throw Exception('Invalid Cloudinary response format');
      }

      final urlStart = urlStartIndex + 14; // Length of '"secure_url":"'
      final urlEndIndex = responseString.indexOf('"', urlStart);

      if (urlEndIndex == -1) {
        throw Exception('Could not extract URL from response');
      }

      return responseString.substring(urlStart, urlEndIndex);
    } catch (e) {
      throw Exception('Error parsing Cloudinary response: $e');
    }
  }

  /// Extract public_id from Cloudinary URL
  String _extractPublicIdFromUrl(String url) {
    try {
      // URL format: https://res.cloudinary.com/[cloud_name]/image/upload/v[version]/[public_id].jpg
      final parts = url.split('/');
      final fileName = parts.last; // Get the filename with extension

      // Remove extension
      final publicId = fileName.split('.').first;

      // Get folder path if exists
      final uploadIndex = parts.indexOf('upload');
      if (uploadIndex != -1 && uploadIndex + 2 < parts.length) {
        // Reconstruct public_id with folder
        final folderAndFile = parts.sublist(uploadIndex + 2).join('/');
        return folderAndFile.split('.').first;
      }

      return publicId;
    } catch (e) {
      throw Exception('Error extracting public_id from URL: $e');
    }
  }
}
