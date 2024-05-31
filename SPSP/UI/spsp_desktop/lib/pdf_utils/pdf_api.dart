import 'dart:io';
import 'package:pdf/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = Directory('C:\\invoices');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future<void> openFile(File file) async {
    var uri = Uri.parse(file.path);
    try {
      await launchUrl(uri);
    } on Exception catch (e) {
      print(e);
    }
  }
}
