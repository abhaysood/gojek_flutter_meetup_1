class Counter {
  Counter({int counter = 0}) : _value = counter;

  int _value;

  int get value => _value;

  void increment() {
    _value = _value + 1;
  }

  void decrement() {
    _value = _value - 1;
  }
}
