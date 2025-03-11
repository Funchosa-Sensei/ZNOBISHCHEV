import 'package:flutter/material.dart';

class InfinityList extends StatefulWidget {
  const InfinityList({Key? key}) : super(key: key);

  @override
  _InfinityListState createState() => _InfinityListState();
}

class _InfinityListState extends State<InfinityList> {
  final List<String> _items = [];

  @override
  void initState() {
    super.initState();
    _addItems();
  }

  void _addItems() {
    setState(() {
      int nextIndex = _items.length;
      _items.addAll([
        'Строка ${nextIndex + 1}',
        'Строка ${nextIndex + 2}',
        'Строка ${nextIndex + 3}',
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text(
          'Бесконечный список (номера строк)',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final int index = i ~/ 2;
          if (index >= _items.length) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _addItems();
              }
            });
            return Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          return ListTile(title: Text(_items[index]));
        },
      ),
    );
  }
}
