import 'package:flutter/material.dart';
import 'package:todo/layout/todoApp/todo_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// ربنا يكرمك
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homeLayout()
    );
  }
}
