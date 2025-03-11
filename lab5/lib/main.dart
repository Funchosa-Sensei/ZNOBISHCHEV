import 'package:flutter/material.dart';
import 'simple_list.dart';
import 'infinity_list.dart';
import 'infinity_math_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторная работа 5',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget _buildNavField(BuildContext context, String title, Widget targetPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      child: Container(
        color: Colors.green[600],
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.only(top: 8.0),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text(
          'Лабораторная работа 5',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildNavField(context, 'Простой список', SimpleList()),
          _buildNavField(
            context,
            'Бесконечный список (номера строк)',
            InfinityList(),
          ),
          _buildNavField(
            context,
            'Бесконечный список (2 в степени)',
            InfinityMathList(),
          ),
        ],
      ),
    );
  }
}
