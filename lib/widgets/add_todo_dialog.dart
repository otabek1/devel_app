import 'package:devel_app/models/todo.dart';
import 'package:devel_app/providers/todos.dart';
import 'package:devel_app/widgets/todo_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTodoDialogWidget extends StatefulWidget {
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Container(
          height: 500,
          padding: EdgeInsets.only(
              // bottom: MediaQuery.of(context).viewInsets.bottom, //+ 10.0,
              ),
          child: AlertDialog(
            scrollable: true,
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Yangi vazifa qo\'shish',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TodoFormWidget(
                      onChangedTitle: (title) =>
                          setState(() => this.title = title),
                      onChangedDescription: (description) =>
                          setState(() => this.description = description),
                      onSavedTodo: addTodo,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void addTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        createdTime: DateTime.now(),
      );

      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);

      Navigator.of(context).pop();
    }
  }
}
