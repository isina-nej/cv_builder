import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CrossPlatformImage extends StatelessWidget {
  final String? imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const CrossPlatformImage({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath == null) {
      return Container(
        height: height ?? 100,
        width: width ?? 100,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.person, size: 40, color: Colors.grey),
      );
    }

    // On web, Image.file doesn't work, so we show a placeholder
    if (kIsWeb) {
      return Container(
        height: height ?? 100,
        width: width ?? 100,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.photo, size: 40, color: Colors.grey),
            const SizedBox(height: 4),
            Text(
              'Photo\nUploaded',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    // On mobile/desktop, use Image.file
    return Image.file(
      File(imagePath!),
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
    );
  }
}
