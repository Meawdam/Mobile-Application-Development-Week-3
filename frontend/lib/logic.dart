import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:frontend/model.dart';

class Connector {
  static const String baseUrl = "http://localhost:3000/todo";
  // get task
  Future<List<dynamic>> getTasks() async {
    try {
      final http.Response res = await http.get(Uri.parse(baseUrl));
      if(res.statusCode != 200) throw Exception('Bad response');
      final List<dynamic> data = jsonDecode(res.body);
      return data;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // add new task

  // delete task

  //edit task

  // toggle task
}