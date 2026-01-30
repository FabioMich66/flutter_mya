import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;
import 'package:image_webp/image_webp.dart'; // abilita encodeWebP

class ImageUtils {
  static Future<List<int>?> pickAndProcessIcon() async {
    // 1. Seleziona file immagine
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return null;

    final bytes = result.files.first.bytes;
    if (bytes == null) return null;

    // 2. Decodifica immagine
    final image = img.decodeImage(bytes);
    if (image == null) return null;

    // 3. Crop quadrato centrale
    final side = image.width < image.height ? image.width : image.height;

    final crop = img.copyCrop(
      image,
      x: (image.width - side) ~/ 2,
      y: (image.height - side) ~/ 2,
      width: side,
      height: side,
    );

    // 4. Resize a 256x256
    final resized = img.copyResize(crop, width: 256, height: 256);

    // 5. Codifica WebP universale
    final webpBytes = img.encodeWebP(
      resized,
      quality: 90,
    );

    return webpBytes;
  }

  static String bytesToDataUrl(List<int> bytes) {
    final base64 = base64Encode(bytes);
    return 'data:image/webp;base64,$base64';
  }
}
