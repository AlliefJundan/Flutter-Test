import 'package:flutter/material.dart';
import '../services/file_service.dart';
import 'list_page.dart';
import 'test.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _fileService = FileService();
  String _name = '';
  String _email = '';
  String _nomor = '';

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await _fileService.saveFormData({
        'name': _name,
        'email': _email,
        'nomor': _nomor,
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Berhasil'),
          content: Text('Data disimpan!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // tutup dialog
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _goToListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListPage()),
    );
  }

  void _test() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Input'),
        backgroundColor: Colors.green,
        actions: [IconButton(icon: Icon(Icons.list), onPressed: _goToListPage)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _name = value ?? '',
                validator: (value) => value!.isEmpty ? 'Isi nama' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _email = value ?? '',
                validator: (value) => value!.isEmpty ? 'Isi email' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nomor',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _nomor = value ?? '',
                validator: (value) => value!.isEmpty ? 'Isi nomor' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text('Simpan'),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _goToListPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text(
                  'Lihat Data',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _test,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text(
                  'Test',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
