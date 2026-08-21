class Task {
  String id = '';
  String title = '';
  bool complete = false;

  Task(this.id, this.title, this.complete);

  @override
  String toString() {
    String status = complete ? '[X]' : '[ ]';
    return '$status $title';
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    json['id'] as String,
    json['title'] as String,
    json['complete'] as bool,
  );
}
