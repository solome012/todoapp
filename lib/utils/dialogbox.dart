import 'package:flutter/material.dart';
import 'package:todo_app/utils/mybutton.dart';

class MyDialogBox extends StatelessWidget {
  final dialogController;
  VoidCallback onSaved;
  VoidCallback onCancel;
  MyDialogBox(
      {super.key,
      required this.dialogController,
      required this.onSaved,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller: dialogController,
              decoration: InputDecoration(
                  hintText: "Add a new task",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),

            //buttons=> save +cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                MyButton(btnText: "Save", onPressed: onSaved),
                const SizedBox(
                  width: 20,
                ),
                //cancel button
                MyButton(btnText: "Cancel", onPressed: onCancel)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
