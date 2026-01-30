import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;
import 'package:webp/webp.dart' as webp;

class ImageUtils {
  static Future<List<int>?> pickAndProcessIcon() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return null;

    final bytes = result.files.first.bytes;
    if (bytes == null) return null;

    final image = img.decodeImage(bytes);
    if (image == null) return null;

    final side = image.width < image.height ? image.width : image.height;
    final crop = img.copyCrop(image,
        x: (image.width - side) ~/ 2,
        y: (image.height - side) ~/ 2,
        width: side,
        height: side);

    final resized = img.copyResize(crop, width: 256, height: 256);
    return webp.encodeWebP(resized);
  }

  static String bytesToDataUrl(List<int> bytes) {
    final base64 = Uri.encodeComponent(String.fromCharCodes(bytes));
    return 'data:image/webp;base64,$base64';
  }
}

