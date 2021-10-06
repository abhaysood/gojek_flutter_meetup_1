import 'package:flutter_test/flutter_test.dart';
import 'package:meetup/src/counter.dart';

void main() {
  test("increments counter", () {
    final counter = Counter(counter: 0)..increment();
    expect(counter.value, 1);
  });

  test("decrements counter", () {
    final counter = Counter(counter: 0)..decrement();
    expect(counter.value, -1);
  });
}
