import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Инкремент',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Инкремент')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Текст "Значение инкремента:"
            const Text('Значение инкремента:', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            // Отдельный текст со значением счётчика
            Text('$_counter', style: const TextStyle(fontSize: 36)),
            const SizedBox(height: 20),
            // Кнопки "-" и "+" без зазора между ними
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Углы убраны
                    ),
                    minimumSize: const Size(80, 50), // Делает кнопку квадратной
                    backgroundColor: Colors.red,
                  ),
                  onPressed: _decrementCounter,
                  child: const Text('-', style: TextStyle(fontSize: 24)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    minimumSize: const Size(80, 50),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: _incrementCounter,
                  child: const Text('+', style: TextStyle(fontSize: 24)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(onPressed: _resetCounter, child: const Text('Сбросить')),
          ],
        ),
      ),
    );
  }
}
