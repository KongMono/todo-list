import 'package:todo_list_app/services/todo_list/models.dart';

class TodoListPageState {
  final List<ListInfo> todoList;

  TodoListPageState({this.todoList = const []});

  TodoListPageState copyWith({List<ListInfo> todoList}) {
    return TodoListPageState(todoList: todoList ?? this.todoList);
  }
}
