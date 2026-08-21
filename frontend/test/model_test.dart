import 'package:frontend/model.dart';
import 'package:test/test.dart';

void main() {
  test('1. Create a new test should have new a new task', () {
    Task task = Task("1", "Cooking", false);

    expect(task.id, 1);
  });
}