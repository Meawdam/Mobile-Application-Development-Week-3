class Task {
  String id = '';
  String title = '';
  bool complete = false;

  Task(this.id, this.title, this.complete);

  String getTask() {
    String status = complete ? '[X]': '[ ]';
    return '$status $title';
  }
}