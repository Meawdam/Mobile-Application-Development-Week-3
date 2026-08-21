import 'package:frontend/logic.dart';
import 'package:frontend/model.dart';
import 'package:test/test.dart';

void main() {
  test('1. Get task should return a task', () async {
    Connector connector = Connector();
    List<Task> data = await connector.getTasks();

    expect(data[0].id, "1");
    expect(data[0].title, "Cooking");
    expect(data[0].complete, false);
  });

  test('2. add task should have a new task', () async {
    Connector connector = Connector();
    await connector.addTasks("Read a Book");

    List<Task> data = await connector.getTasks();
    expect(data.last.title, 'Read a Book');
    expect(data.last.complete, false);
  });

  test('3. Delete task a task should be deleted', () async {
    Connector connector = Connector();
    await connector.addTasks("Read a Book");

    List<Task> data = await connector.getTasks();
    await connector.deleteTasks(data[0].id);

    data = await connector.getTasks();
    expect(data.any((task) => task.id == '1'), isFalse);
  });

  test('4. Edit task should update its title', () async {
    final Connector connector = Connector();
    await connector.addTasks('Original title');

    final List<Task> tasks = await connector.getTasks();
    final Task task = tasks.last;
    await connector.editTasks(task.id, 'Updated title');

    final List<Task> updatedTasks = await connector.getTasks();
    final Task updatedTask = updatedTasks.firstWhere(
      (item) => item.id == task.id,
    );
    expect(updatedTask.title, 'Updated title');
    expect(updatedTask.complete, false);
  });

  test('5. Toggle task should update its completion status', () async {
    final Connector connector = Connector();
    await connector.addTasks('Toggle me');

    final List<Task> tasks = await connector.getTasks();
    final Task task = tasks.last;
    await connector.toggleTasks(task.id);

    final List<Task> updatedTasks = await connector.getTasks();
    final Task updatedTask = updatedTasks.firstWhere(
      (item) => item.id == task.id,
    );
    expect(updatedTask.complete, isTrue);
  });

  test('6. Search tasks by name should return matching tasks', () async {
    final Connector connector = Connector();
    const String titleToSearch = 'Search Target Task';
    await connector.addTasks(titleToSearch);
    final List<Task> searchResults = await connector.searchTasksByTitle(
      'Search Target',
    );

    expect(searchResults, isNotEmpty);
    expect(searchResults.any((task) => task.title == titleToSearch), isTrue);
  });
}
