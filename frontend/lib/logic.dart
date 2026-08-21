import 'dart:convert';

import 'package:frontend/model.dart';
import 'package:http/http.dart' as http;

class Connector {
  static const String baseUrl = "http://localhost:3000/todo";
  // get task
  Future<List<Task>> getTasks() async {
    try {
      final http.Response res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode != 200) throw Exception('Bad response');
      final List<dynamic> data = jsonDecode(res.body) as List<dynamic>;
      return data
          .map((json) => Task.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // add new task
  Future<void> addTasks(String title) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'title': title, 'complete': false});
      final http.Response res = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: body,
      );
      if (res.statusCode != 201) throw Exception('Bad response');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // delete task
  Future<void> deleteTasks(String id) async {
    try {
      final http.Response res = await http.delete(
        Uri.parse('$baseUrl/$id'),
      );
      if (res.statusCode != 200) throw Exception('Bad response');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // edit task
  Future<void> editTasks(String id, String title) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({'title': title});
      final http.Response res = await http.patch(
        Uri.parse('$baseUrl/$id'),
        headers: headers,
        body: body,
      );
      if (res.statusCode != 200) throw Exception('Bad response');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // toggle task
}
