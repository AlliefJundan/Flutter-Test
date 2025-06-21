import 'package:flutter/material.dart';
import '../services/file_service.dart';

class ListPage extends StatelessWidget {
  final FileService _fileService = FileService();

  Future<List<Map<String, dynamic>>> _loadData() async {
    return await _fileService.loadFormData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Data"), backgroundColor: Colors.green),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final dataList = snapshot.data ?? [];

          if (dataList.isEmpty) {
            return Center(child: Text("Tidak ada data yang tersedia"));
          }

          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final item = dataList[index];
              return ListTile(
                title: Text(item['name'] ?? ''),
                subtitle: Text(
                  'Email: ${item['email'] ?? ''}\nNomor: ${item['nomor'] ?? ''}\nTimestamp: ${item['timestamp'] ?? ''}',
                ),
                isThreeLine: true,
                leading: Icon(Icons.person),
              );
            },
          );
        },
      ),
    );
  }
}
