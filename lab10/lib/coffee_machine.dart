import 'resources.dart';
import 'enums.dart';
import 'icoffee.dart';
import 'cappuccino.dart';
import 'espresso.dart';
import 'americano.dart';

class CoffeeMachine {
  ICoffee? _coffee;

  void selectCoffee(CoffeeType type) {
    switch (type) {
      case CoffeeType.cappuccino:
        _coffee = Cappuccino();
        break;
      case CoffeeType.espresso:
        _coffee = Espresso();
        break;
      case CoffeeType.americano:
        _coffee = Americano();
        break;
    }
  }

  Resources makeCoffee() {
    if (_coffee == null) {
      throw Exception('Coffee type not selected');
    }

    return Resources(
      water: _coffee!.water(),
      milk: _coffee!.milk(),
      beans: _coffee!.beans(),
    );
  }
}
