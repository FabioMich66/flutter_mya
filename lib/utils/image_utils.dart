import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_image_converter/flutter_image_converter.dart';

class ImageUtils {
  /// Seleziona un'immagine, la croppa quadrata, la ridimensiona a 256x256
  /// e la converte in WebP universale.
  static Future<List<int>?> pickAndProcessIcon() async {
    // 1. Selezione file
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

    // 5. PNG temporaneo (image package è molto stabile per manipolazioni)
    final pngBytes = img.encodePng(resized);

    // 6. Conversione PNG → WebP universale
    final webpBytes = await FlutterImageConverter.convert(
      pngBytes,
      ImageFormat.png,
      ImageFormat.webp,
      quality: 90,
    );

    return webpBytes;
  }

  /// Converte i bytes WebP in un Data URL per usarlo in Image.memory o HTML
  static String bytesToDataUrl(List<int> bytes) {
    final base64 = base64Encode(bytes);
    return 'data:image/webp;base64,$base64';
  }
}
