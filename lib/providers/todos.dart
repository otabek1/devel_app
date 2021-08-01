import 'package:devel_app/helpers/todo_db.dart';
import 'package:devel_app/models/todo.dart';
import 'package:flutter/cupertino.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  Future<List<Todo>> get todos async {
    var data = await TodoDB.getData();
    data.forEach((element) {
      var fromJson = Todo.fromJson(element);
      if (_todos.indexWhere((element) => element.id == fromJson.id) == -1) {
        _todos.add(fromJson);
      }
    });
    print("length ${_todos.length}");
    return _todos;
  }

  // List<Todo> get todosCompleted =>
  //     _todos.where((todo) => todo.isDone == true).toList();

  void setTodos(List<Todo>? todos) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _todos = todos!;
        notifyListeners();
      });

  void addTodo(Todo todo) {
    TodoDB.insert(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.removeWhere((element) => element.id == todo.id);
    TodoDB.delete(todo.id);
    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    TodoDB.updateDone(todo);
    notifyListeners();
    return todo.isDone;
  }

  // void updateTodo(Todo todo, String title, String description) {
  //   todo.title = title;
  //   todo.description = description;

  //   FirebaseApi.updateTodo(todo);
  // }

}
