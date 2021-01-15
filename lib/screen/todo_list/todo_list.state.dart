import 'package:todo_list_app/services/todo_list/models.dart';

class TodoListPageState {
  final List<ListInfo> todoList;
  final SelectedDate selectedDate;

  TodoListPageState({
    this.todoList = const [],
    this.selectedDate
  });

  TodoListPageState copyWith({List<ListInfo> todoList, SelectedDate selectedDate}) {
    return TodoListPageState(todoList: todoList ?? this.todoList, selectedDate: selectedDate ?? this.selectedDate);
  }
}
