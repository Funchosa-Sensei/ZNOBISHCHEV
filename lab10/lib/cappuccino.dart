import 'icoffee.dart';

class Cappuccino implements ICoffee {
  @override
  int beans() => 20;

  @override
  int milk() => 150;

  @override
  int water() => 50;
}
