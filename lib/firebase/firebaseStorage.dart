import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImage(File imageFile) async {
  try {
    String fileName = imageFile.path.split('/').last;
    Reference ref = FirebaseStorage.instance.ref().child('profiles/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);
    await uploadTask.whenComplete(() => null);
    return 'profiles/$fileName';
  } catch (e) {
    print('Error uploading image: $e');
    return "";
  }
}

Future<String> getImageUrl(String imagePath) async {
  try {
    final path = FirebaseStorage.instance.ref().child(imagePath);
    final downloadUrl = await path.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    throw Exception('Failed to get image URL');
  }
}
