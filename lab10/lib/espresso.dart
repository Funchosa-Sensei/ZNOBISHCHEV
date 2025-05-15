import 'icoffee.dart';

class Espresso implements ICoffee {
  @override
  int beans() => 20;

  @override
  int milk() => 0;

  @override
  int water() => 50;
}
