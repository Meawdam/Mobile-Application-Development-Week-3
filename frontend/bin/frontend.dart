import 'dart:io';

import 'package:frontend/logic.dart';
import 'package:frontend/model.dart';

void main() async{
  final connector = Connector(); 
  print('--- Welcome to the Dart TODO Console ---');
  String? input;

  while(input != '7') {
    showMenu();
    stdout.write('Select an option : ');
    input = stdin.readLineSync();

    switch(input) {
      case '1':
        viewTasks(connector);
      case '7':
        print('Good bye!');
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

Future<void> viewTasks(Connector c) async{
  try {
    List<Task> todos = await c.getTasks();
    if(todos.isEmpty) throw Exception('No task found');
    for(var (i, todo) in todos.indexed) {
      print('${i+1} : $todo');
    }
  } catch (e) {
    throw Exception('Error $e');
  }
}
