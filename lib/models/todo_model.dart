class Todo {
  String title;
  String description;
  String id;

  Todo({
    required this.title,
    required this.description,
    required this.id,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      description: json['description'],
      id: json['_id'],
    );
  }
}
