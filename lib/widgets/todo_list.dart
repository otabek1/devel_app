import 'package:devel_app/models/todo.dart';
import 'package:devel_app/providers/todos.dart';
import 'package:devel_app/widgets/todo_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    return FutureBuilder(
        future: provider.todos,
        builder: (context, AsyncSnapshot<List<Todo>> todos) {
          if (todos.hasData) {
            print("toodo frmo list ${todos.data}");
            return todos.data!.isEmpty
                ? Center(
                    child: Text(
                      'Hech qanday vazifalar mavjud emas.',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(16),
                    separatorBuilder: (context, index) => Container(height: 8),
                    itemCount: todos.data!.length,
                    itemBuilder: (context, index) {
                      final todo = todos.data![index];
                      print("todo ${todo.toJson()}");
                      return TodoWidget(todo: todo);
                    },
                  );
          } else {
            print("todooo ${todos.data}");
            return Center(
              child: Text("No todos"),
            );
          }
        });
  }
}
