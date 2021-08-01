import 'package:devel_app/models/todo.dart';
import 'package:devel_app/providers/todos.dart';
import 'package:devel_app/widgets/add_todo_dialog.dart';
import 'package:devel_app/widgets/drawer.dart';
import 'package:devel_app/widgets/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatelessWidget {
  static const routeName = "/todo";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Todo"),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddTodoDialogWidget(),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add),
      ),
      body: //FutureBuilder(
          //     future: Provider.of<TodosProvider>(context).todos,
          //     builder: (context, AsyncSnapshot<List<Todo>> data) {
          //       if (data.connectionState == ConnectionState.waiting) {
          //         return Text("Waiting");
          //       } else if (data.hasData) {
          //         if (data.data != null) {
          //           // Provider.of<TodosProvider>(context).setTodos(data.data);
          //           return
          TodoListWidget(),

      //   }
      //   print("data  ${data.data}");
      //   return Text('NOthing');
      // }),
    );
  }
}
