import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List todoList = [];
  //reference the box
  final _myBox = Hive.box('mybox');

  //run this method if this is the 1st time ever opening this app
  void createInitalData() {
    todoList = [
      ["Do Study", false],
      ["Do workout", false]
    ];
  }

  //load the datta from the database
  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateData() {
    _myBox.put("TODOLIST", todoList);
  }
}
