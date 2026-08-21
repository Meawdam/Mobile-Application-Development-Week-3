import 'dart:io';

import 'package:frontend/logic.dart';
import 'package:frontend/model.dart';

void main() async {
  final connector = Connector();
  print('--- Welcome to the Dart TODO Console ---');
  String? input;

  while (input != '7') {
    showMenu();
    stdout.write('Select an option : ');
    input = stdin.readLineSync();

    switch (input) {
      case '1':
        await viewTasks(connector);
        break;
      case '7':
        print('Good bye!');
        break;
      default:
        print('Invalid selection, please select only 1-7!');
    }
  }
}

void showMenu() {
 print('\n======== Menu ========');
 print('1. View Tasks');
 print('2. Add New Task');
 print('3. Delete Task');
 print('4. Toggle Task Status');
 print('5. Edit Task');
 print('6. Search Task');
 print('7. Exit');
}

Future<void> viewTasks(Connector connector) async {
  try {
    final List<Task> todos = await connector.getTasks();
    if (todos.isEmpty) {
      print('\nNo tasks found.');
      return;
    }

    print('-------------------');
    for (var (index, todo) in todos.indexed) {
      print('${index + 1}. $todo');
    }
  } catch (e) {
    print('Error: $e');
  }
}
