import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Page'), backgroundColor: Colors.blue),
      body: Center(
        child: Text('This is a test page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
