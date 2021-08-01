import '../utils.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;

  Todo({
    required this.createdTime,
    required this.title,
    this.description = '',
    this.id = "",
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
        "createdTime": createdTime.toString(),
        "title": title,
        "description": description,
        "id": id,
        "isDone": isDone ? 1 : 0,
      };

  static Todo fromJson(Map<String, dynamic> json) => Todo(
      createdTime: DateTime.parse(json["createdTime"]),
      title: json["title"],
      description: json["description"],
      id: json["id"],
      isDone: json["isDone"]==1 ?true :false );
}
