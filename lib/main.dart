import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list_app/screen/login/login.page.dart';
import 'package:todo_list_app/screen/todo_list/todo_list.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/todo_list": (context) => TodoListPage(),
      },
    );
  }
}
