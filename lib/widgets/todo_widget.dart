import 'package:devel_app/models/todo.dart';
import 'package:devel_app/providers/todos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Dismissible(
          key: ValueKey(todo.id),
          confirmDismiss: (direction) {
            return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: Text("Haqiqatdan ham o'chirmoqchimisiz?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text("Ha")),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text("Yo'q"))
                      ],
                    ));
          },
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            Provider.of<TodosProvider>(context, listen: false).removeTodo(todo);
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("ToDo o'chirildi"),
              duration: Duration(seconds: 2),
            ));
            print("removing");
          },
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 32,
                ),
              ],
            ),
          ),
          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => Card(
        elevation: 10,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: todo.isDone,
                onChanged: (_) {
                  Provider.of<TodosProvider>(context, listen: false)
                      .toggleTodoStatus(todo);
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (todo.description.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          todo.description,
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
