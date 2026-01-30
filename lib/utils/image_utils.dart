import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;

class ImageUtils {
  static Future<List<int>?> pickAndProcessIcon() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return null;

    final bytes = result.files.first.bytes;
    if (bytes == null) return null;

    final image = img.decodeImage(bytes);
    if (image == null) return null;

    final side = image.width < image.height ? image.width : image.height;

    final crop = img.copyCrop(
      image,
      x: (image.width - side) ~/ 2,
      y: (image.height - side) ~/ 2,
      width: side,
      height: side,
    );

    final resized = img.copyResize(crop, width: 256, height: 256);

    // WebP universale (image 4.1.3)
    final webpBytes = img.encodeWebP(resized, quality: 90);

    return webpBytes;
  }

  static String bytesToDataUrl(List<int> bytes) {
    final base64 = base64Encode(bytes);
    return 'data:image/webp;base64,$base64';
  }
}
