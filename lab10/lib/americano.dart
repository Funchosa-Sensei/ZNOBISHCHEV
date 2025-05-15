import 'icoffee.dart';

class Americano implements ICoffee {
  @override
  int beans() => 20;

  @override
  int milk() => 0;

  @override
  int water() => 100;
}
