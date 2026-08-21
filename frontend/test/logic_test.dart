import 'package:frontend/logic.dart';
import 'package:frontend/model.dart';
import 'package:test/test.dart';

void main() {
  test('1. Get task should return a task', () async{
    Connector connector = Connector();
    List<Task> data = await connector.getTasks();

    expect(data[0].id, "1");
    expect(data[0].title, "Cooking");
    expect(data[0].complete, false);
  });

  test('2. add task should have a new task', () async{
    Connector connector = Connector();
    await connector.addTasks("Read a Book");

    List<Task> data = await connector.getTasks();
    expect(data.last.title, 'Read a Book');
    expect(data.last.complete, false);
  });
}
