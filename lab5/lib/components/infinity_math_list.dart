import 'package:flutter/material.dart';
import 'dart:math';

class InfinityMathList extends StatelessWidget {
  const InfinityMathList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text(
          'Бесконечный список (2 в степени)',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final int index = i ~/ 2;
          num result = pow(2, index);
          return ListTile(title: Text('2^$index = $result'));
        },
      ),
    );
  }
}
