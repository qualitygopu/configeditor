import 'dart:convert';
import 'dart:html' as html;

class JsonService {
  Future<String?> pickJsonFile() async {
    final uploadInput = html.FileUploadInputElement();

    uploadInput.accept = '.json';

    uploadInput.click();

    await uploadInput.onChange.first;

    final file = uploadInput.files?.first;

    if (file == null) return null;

    final reader = html.FileReader();

    reader.readAsText(file);

    await reader.onLoad.first;

    return reader.result as String;
  }

  void downloadJson(Map<String, dynamic> jsonData, String fileName) {
    final jsonString = const JsonEncoder.withIndent("  ").convert(jsonData);

    final bytes = utf8.encode(jsonString);

    final blob = html.Blob([bytes]);

    final url = html.Url.createObjectUrl(blob);

    html.AnchorElement()
      ..href = url
      ..download = fileName
      ..click();

    html.Url.revokeObjectUrl(url);
  }
}
