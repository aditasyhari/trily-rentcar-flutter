import 'package:flutter/material.dart';

button(String text, Function onPressed) {
  return MaterialButton(
    onPressed: () => onPressed(),
    height: 50,
    elevation: 0,
    splashColor: Colors.blue[700],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
    color: Colors.blue[900],
    child: Center(
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18),),
    ),
  );
}