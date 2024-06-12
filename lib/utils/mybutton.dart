import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;
  const MyButton({super.key, required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.yellow,
      //color: Theme.of(context).colorScheme.primary,
      onPressed: onPressed,
      child: Text(btnText),
    );
  }
}
