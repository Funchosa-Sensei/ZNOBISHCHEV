import 'coffee_machine.dart';
import 'enums.dart';

void main() {
  final coffeeMachine = CoffeeMachine();

  coffeeMachine.selectCoffee(CoffeeType.cappuccino);

  final resources = coffeeMachine.makeCoffee();

  print('Water: ${resources.water}ml');
  print('Milk: ${resources.milk}ml');
  print('Beans: ${resources.beans}g');

  coffeeMachine.selectCoffee(CoffeeType.espresso);
  final espressoResources = coffeeMachine.makeCoffee();

  print('\nEspresso:');
  print('Water: ${espressoResources.water}ml');
  print('Milk: ${espressoResources.milk}ml');
  print('Beans: ${espressoResources.beans}g');
}
