import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор площади',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Калькулятор площади'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String _resultText = '';

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculateArea() {
    if (_formKey.currentState!.validate()) {
      double width = double.parse(_widthController.text);
      double height = double.parse(_heightController.text);
      double area = width * height;

      setState(() {
        _resultText = 'S = $width * $height = $area (мм2)';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Расчёт выполнен успешно!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    margin: const EdgeInsets.only(top: 14),
                    child: const Text(
                      'Ширина (мм):',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _widthController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+(\.\d+)?$'),
                        ),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Заполните ширину';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Некорректное число';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    margin: const EdgeInsets.only(top: 14),
                    child: const Text(
                      'Высота (мм):',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+(\.\d+)?$'),
                        ),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Заполните высоту';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Некорректное число';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _calculateArea,
                  child: const Text('Вычислить'),
                ),
              ),

              const SizedBox(height: 16.0),
              const Center(
                child: Text(
                  'задайте параметры',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 24.0),
              Text(_resultText, style: const TextStyle(fontSize: 20.0)),
            ],
          ),
        ),
      ),
    );
  }
}
