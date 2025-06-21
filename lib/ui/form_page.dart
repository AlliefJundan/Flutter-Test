import 'package:flutter/material.dart';
import '../services/file_service.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _fileService = FileService();
  String _name = '';
  String _email = '';
  List<Map<String, dynamic>> _formDataList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await _fileService.loadFormData();
    setState(() {
      _formDataList = data;
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await _fileService.saveFormData({'name': _name, 'email': _email});
      await _loadData();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Form Submitted'),
          content: Text('Name: $_name\nEmail: $_email'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Page'), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => _name = value ?? '',
                    validator: (value) =>
                        value!.isEmpty ? 'Enter your name' : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => _email = value ?? '',
                    validator: (value) =>
                        value!.isEmpty ? 'Enter your email' : null,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _formDataList.length,
                itemBuilder: (context, index) {
                  final item = _formDataList[index];
                  return ListTile(
                    title: Text(item['name'] ?? ''),
                    subtitle: Text(
                      '${item['email'] ?? ''}\n${item['timestamp'] ?? ''}',
                    ),
                    isThreeLine: true,
                    leading: Icon(Icons.person),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
