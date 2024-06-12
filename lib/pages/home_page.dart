import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/utils/dialogbox.dart';
import 'package:todo_app/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('mybox');
  final controller = TextEditingController();
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    //if this is the first time ever opeing the app
    //then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitalData();
    } else {
      //already exist data
      db.loadData();
    }
    super.initState();
  }

  //checkbox was tapped
  void checkBoxChanged(bool value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

  //create New task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return MyDialogBox(
            dialogController: controller,
            onSaved: saveNewTask,
            onCancel: () {
              return Navigator.of(context).pop();
            },
          );
        });
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.todoList.add([controller.text, false]);
      Navigator.pop(context);
      controller.clear();
    });
    //update the database
    db.updateData();
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    //update the database
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        elevation: 0,
        title: const Center(
          child: Text(
            "TO DO",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => checkBoxChanged(value!, index),
            deleteFunction: (p0) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow,
          onPressed: createNewTask,
          child: const Icon(
            Icons.add,
            color: Colors.black,
          )),
    );
  }
}
