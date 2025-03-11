import 'package:flutter/material.dart';

class SimpleList extends StatelessWidget {
  const SimpleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text('Простой список', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          ListTile(title: Text('0000')),
          ListTile(title: Text('0001')),
          ListTile(title: Text('0010')),
        ],
      ),
    );
  }
}
