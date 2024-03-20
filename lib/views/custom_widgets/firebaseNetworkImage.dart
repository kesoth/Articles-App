import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirebaseNetworkImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorBuilder;

  const FirebaseNetworkImage({
    required this.imagePath,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.fill,
    this.placeholder,
    this.errorBuilder,
  });

  Future<String> getImageUrl(String imagePath) async {
    try {
      final path = FirebaseStorage.instance.ref().child(imagePath);
      final downloadUrl = await path.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to get image URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getImageUrl(imagePath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: EdgeInsets.only(left: 75.w, top: 30.w),
            child: placeholder ?? const CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return errorBuilder ?? Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final imageUrl = snapshot.data!;
          return Image(
            image: NetworkImage(imageUrl),
            width: width,
            height: height,
            fit: fit,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
