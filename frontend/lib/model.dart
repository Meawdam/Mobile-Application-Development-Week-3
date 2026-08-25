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
    '${json['id'] ?? ''}',
    '${json['title'] ?? ''}',
    json['complete'] == true,
  );
}
