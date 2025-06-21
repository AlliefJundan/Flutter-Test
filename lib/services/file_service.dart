import 'dart:convert';
import 'dart:io';

class FileService {
  final String customPath =
      '/storage/emulated/0/Download/MyAppData/form_data.json';

  Future<void> saveFormData(Map<String, dynamic> data) async {
    final file = File(customPath);

    List<dynamic> existingData = [];

    if (await file.exists()) {
      try {
        final content = await file.readAsString();
        existingData = jsonDecode(content);
        if (existingData is! List) existingData = [];
      } catch (e) {
        existingData = [];
      }
    }

    data['timestamp'] = DateTime.now().toIso8601String();
    existingData.add(data);

    await file.writeAsString(jsonEncode(existingData));
  }

  Future<List<Map<String, dynamic>>> loadFormData() async {
    final file = File(customPath);

    if (!await file.exists()) return [];

    try {
      final content = await file.readAsString();
      final List<dynamic> data = jsonDecode(content);
      return data.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }
}
