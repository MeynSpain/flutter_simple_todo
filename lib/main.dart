import 'package:flutter/material.dart';

import 'model/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> todos = [];

  loadData() async {
    todos = await Todo().select().toList();

    setState(() {});
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  todoAdd(String todoTitle) async {
    Todo todoToAdd = new Todo();
    todoToAdd.title = todoTitle;
    todoToAdd.completed = false;
    await todoToAdd.save();

    loadData();
  }

  showTodoAddDialog() {
    String newTitle = "";

    return showDialog(
        context: context,
        builder: (_) =>
        new AlertDialog(
          title: Text("Add task"),
          content: TextField(onChanged: (value) => newTitle = value,),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  todoAdd(newTitle);
                  Navigator.pop(context);
                },
                child: Text("Add"))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My test ToDo"),
          centerTitle: true,
          toolbarHeight: 80,
          actions: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await Todo()
                      .select()
                      .completed
                      .equals(true)
                      .delete();
                  loadData();
                })
          ],
        ),
        floatingActionButton: IconButton(
          icon: Icon(Icons.add),
          onPressed: showTodoAddDialog,
        ),
        body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext cntxt, int index) {
              return ListTile(
                title: Text(todos[index].title ?? ""),
                trailing: todos[index].completed == true
                    ? Icon(Icons.check_box)
                    : Icon(Icons.check_box_outline_blank),
                onTap: () async {
                  todos[index].completed = !todos[index].completed!;
                  await todos[index].save();
                  loadData();
                },
              );
            }));
  }
}
