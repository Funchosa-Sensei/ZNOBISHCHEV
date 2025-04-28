class Machine {
  int _coffeeBeans;
  int _milk;
  int _water;
  double _cash;

  Machine({int coffeeBeans = 0, int milk = 0, int water = 0, double cash = 0.0})
    : _coffeeBeans = coffeeBeans,
      _milk = milk,
      _water = water,
      _cash = cash;

  int get coffeeBeans => _coffeeBeans;
  set coffeeBeans(int value) => _coffeeBeans = value;

  int get milk => _milk;
  set milk(int value) => _milk = value;

  int get water => _water;
  set water(int value) => _water = value;

  double get cash => _cash;
  set cash(double value) => _cash = value;

  bool isAvailableForEspresso() {
    return _coffeeBeans >= 50 && _water >= 100;
  }

  bool isAvailableForCappuccino() {
    return _coffeeBeans >= 50 && _water >= 50 && _milk >= 150;
  }

  void _subtractEspressoResources() {
    _coffeeBeans -= 50;
    _water -= 100;
  }

  void _subtractCappuccinoResources() {
    _coffeeBeans -= 50;
    _water -= 50;
    _milk -= 150;
  }

  void makingEspresso() {
    if (isAvailableForEspresso()) {
      _subtractEspressoResources();
      addCash(100);
      print('Ваш эспрессо готов!');
    } else {
      print('Недостаточно ресурсов для приготовления эспрессо!');
    }
  }

  void makingCappuccino() {
    if (isAvailableForCappuccino()) {
      _subtractCappuccinoResources();
      addCash(150);
      print('Ваш капучино готов!');
    } else {
      print('Недостаточно ресурсов для приготовления капучино!');
    }
  }

  void addResources({int coffeeBeans = 0, int milk = 0, int water = 0}) {
    _coffeeBeans += coffeeBeans;
    _milk += milk;
    _water += water;
  }

  void addCash(double amount) {
    _cash += amount;
  }

  void spendCash(double amount) {
    if (_cash >= amount) {
      _cash -= amount;
    } else {
      print('Недостаточно денежных средств!');
    }
  }

  void resetCash() {
    _cash = 0;
  }

  void displayStatus() {
    print('Состояние кофемашины:');
    print('Кофейные зерна: $_coffeeBeans г');
    print('Молоко: $_milk мл');
    print('Вода: $_water мл');
    print('Денежные средства: $_cash руб');
  }
}
