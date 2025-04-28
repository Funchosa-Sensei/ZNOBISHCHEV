import 'package:flutter/material.dart';
import 'classes/machine.dart';

void main() {
  runApp(const CoffeeApp());
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Machine',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
      ),
      home: const CoffeeMachineScreen(),
    );
  }
}

class CoffeeMachineScreen extends StatefulWidget {
  const CoffeeMachineScreen({super.key});

  @override
  _CoffeeMachineScreenState createState() => _CoffeeMachineScreenState();
}

class _CoffeeMachineScreenState extends State<CoffeeMachineScreen> {
  final Machine _machine = Machine(
    coffeeBeans: 150,
    milk: 500,
    water: 900,
    cash: 0.0,
  );

  String _message = 'Добро пожаловать в Coffee Machine!';

  void _prepareEspresso() {
    setState(() {
      if (_machine.isAvailableForEspresso()) {
        _machine.makingEspresso();
        _message = 'Ваш эспрессо готов! (+100 руб)';
      } else {
        _message = 'Недостаточно ресурсов для приготовления эспрессо!';
      }
    });
  }

  void _prepareCappuccino() {
    setState(() {
      if (_machine.isAvailableForCappuccino()) {
        _machine.makingCappuccino();
        _message = 'Ваш капучино готов! (+150 руб)';
      } else {
        _message = 'Недостаточно ресурсов для приготовления капучино!';
      }
    });
  }

  void _addResources() {
    setState(() {
      _machine.addResources(coffeeBeans: 50, milk: 100, water: 100);
      _message = 'Ресурсы добавлены!';
    });
  }

  void _addMoney() {
    setState(() {
      _machine.addCash(100);
      _message = 'Деньги добавлены!';
    });
  }

  void _resetCash() {
    setState(() {
      _machine.resetCash();
      _message = 'Денежные средства обнулены!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Machine'),
        backgroundColor: Colors.brown[800]?.withOpacity(0.8),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black54,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.brown[700]?.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Текущее состояние:',
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(
                              color: Colors.orange[200],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildResourceRow(
                            icon: Icons.coffee,
                            label: 'Кофейные зерна:',
                            value: '${_machine.coffeeBeans} г',
                          ),
                          _buildResourceRow(
                            icon: Icons.local_drink,
                            label: 'Молоко:',
                            value: '${_machine.milk} мл',
                          ),
                          _buildResourceRow(
                            icon: Icons.water_drop,
                            label: 'Вода:',
                            value: '${_machine.water} мл',
                          ),
                          _buildResourceRow(
                            icon: Icons.attach_money,
                            label: 'Денежные средства:',
                            value: '${_machine.cash} руб',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    label: 'Приготовить эспрессо',
                    icon: Icons.local_cafe,
                    onPressed: _prepareEspresso,
                  ),
                  _buildActionButton(
                    label: 'Приготовить капучино',
                    icon: Icons.coffee_outlined,
                    onPressed: _prepareCappuccino,
                  ),
                  _buildActionButton(
                    label: 'Добавить ресурсы',
                    icon: Icons.add,
                    onPressed: _addResources,
                  ),
                  _buildActionButton(
                    label: 'Добавить деньги',
                    icon: Icons.account_balance_wallet,
                    onPressed: _addMoney,
                  ),
                  _buildActionButton(
                    label: 'Обнулить деньги',
                    icon: Icons.money_off,
                    onPressed: _resetCash,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResourceRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange[200]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 20),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown[600],
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
