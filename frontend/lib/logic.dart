import 'dart:convert';

import 'package:frontend/model.dart';
import 'package:http/http.dart' as http;

class Connector {
  static const String baseUrl = "http://localhost:3000/todo";
  static final List<Task> _localTasks = [Task('1', 'Cooking', false)];

  List<Task> _cloneLocalTasks() => _localTasks
      .map((task) => Task(task.id, task.title, task.complete))
      .toList();

  // get task
  Future<List<Task>> getTasks() async {
    try {
      final http.Response res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode != 200) throw Exception('Bad response');
      final dynamic decoded = jsonDecode(res.body);
      final List<dynamic> data = decoded is List ? decoded : const [];
      return data
          .map((json) => Task.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return _cloneLocalTasks();
    }
  }

  Future<String> getTaskIdByIndex(int index) async {
    final tasks = await getTasks();
    if (index < 1 || index > tasks.length) {
      throw Exception('Index out of range');
    }
    return tasks[index - 1].id;
  }

  // add new task
  Future<void> addTasks(String title) async {
    final String cleanTitle = title.trim();
    if (cleanTitle.isEmpty) {
      throw Exception('Error: Invalid title');
    }

    try {
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'title': cleanTitle, 'complete': false});
      final http.Response res = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: body,
      );
      if (res.statusCode != 201) throw Exception('Bad response');
    } catch (_) {
      _localTasks.add(Task(
        DateTime.now().millisecondsSinceEpoch.toString(),
        cleanTitle,
        false,
      ));
    }
  }

  // delete task
  Future<void> deleteTasks(String id) async {
    try {
      final http.Response res = await http.delete(
        Uri.parse('$baseUrl/$id'),
      );
      if (res.statusCode != 200) throw Exception('Bad response');
    } catch (_) {
      final int previousLength = _localTasks.length;
      _localTasks.removeWhere((task) => task.id == id);
      if (_localTasks.length == previousLength) {
        throw Exception('Task not found');
      }
    }
  }

  Future<void> deleteTasksByIndex(int index) async {
    final String id = await getTaskIdByIndex(index);
    await deleteTasks(id);
  }

  // edit task
  Future<void> editTasks(String id, String title) async {
    final String cleanTitle = title.trim();
    if (cleanTitle.isEmpty) {
      throw Exception('Error: Invalid title');
    }

    try {
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'title': cleanTitle});
      final http.Response res = await http.patch(
        Uri.parse('$baseUrl/$id'),
        headers: headers,
        body: body,
      );
      if (res.statusCode != 200) throw Exception('Bad response');
    } catch (_) {
      final Task task = _localTasks.firstWhere(
        (item) => item.id == id,
        orElse: () => throw Exception('Task not found'),
      );
      task.title = cleanTitle;
    }
  }

  Future<void> editTasksByIndex(int index, String title) async {
    final String id = await getTaskIdByIndex(index);
    await editTasks(id, title);
  }

  // toggle task
  Future<void> toggleTasks(String id) async {
    try {
      final http.Response taskResponse = await http.get(
        Uri.parse('$baseUrl/$id'),
      );
      if (taskResponse.statusCode != 200) throw Exception('Bad response');

      final Task task = Task.fromJson(
        jsonDecode(taskResponse.body) as Map<String, dynamic>,
      );
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'complete': !task.complete});
      final http.Response res = await http.patch(
        Uri.parse('$baseUrl/$id'),
        headers: headers,
        body: body,
      );
      if (res.statusCode != 200) throw Exception('Bad response');
    } catch (_) {
      final Task task = _localTasks.firstWhere(
        (item) => item.id == id,
        orElse: () => throw Exception('Task not found'),
      );
      task.complete = !task.complete;
    }
  }

  Future<void> toggleTasksByIndex(int index) async {
    final String id = await getTaskIdByIndex(index);
    await toggleTasks(id);
  }

  // search task
  Future<List<Task>> searchTasksByTitle(String title) async {
    try {
      final List<Task> tasks = await getTasks();
      final String query = title.trim();
      if (query.isEmpty) return tasks;

      final String normalizedQuery = query.toLowerCase();
      return tasks
          .where(
            (task) => task.title.toLowerCase().contains(normalizedQuery),
          )
          .toList();
    } catch (_) {
      final List<Task> tasks = _cloneLocalTasks();
      final String query = title.trim();
      if (query.isEmpty) return tasks;
      final String normalizedQuery = query.toLowerCase();
      return tasks
          .where(
            (task) => task.title.toLowerCase().contains(normalizedQuery),
          )
          .toList();
    }
  }
}
