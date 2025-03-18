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
  final List<String> _units = ['мм', 'см', 'м'];
  String _selectedUnit = 'мм';
  String _resultText = '';

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculateArea() {
    bool isFormValid = _formKey.currentState!.validate();
    if (isFormValid) {
      double width = double.parse(_widthController.text);
      double height = double.parse(_heightController.text);
      double convertedWidth = width;
      double convertedHeight = height;

      if (_selectedUnit == 'см') {
        convertedWidth = width * 10;
        convertedHeight = height * 10;
      } else if (_selectedUnit == 'м') {
        convertedWidth = width * 1000;
        convertedHeight = height * 1000;
      }

      double areaInMm2 = convertedWidth * convertedHeight;
      double displayedArea = areaInMm2;

      if (_selectedUnit == 'см') {
        displayedArea = areaInMm2 * 0.01;
      } else if (_selectedUnit == 'м') {
        displayedArea = areaInMm2 * 0.000001;
      }

      setState(() {
        _resultText = 'S = $width × $height = $displayedArea ${_selectedUnit}²';
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
                children: [
                  const Text('Единицы измерения: '),
                  DropdownButton<String>(
                    value: _selectedUnit,
                    items:
                        _units.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedUnit = newValue!;
                      });
                    },
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
                      'Ширина:',
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
                      'Высота:',
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
