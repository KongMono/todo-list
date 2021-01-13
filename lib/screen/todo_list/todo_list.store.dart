import 'package:flutter/widgets.dart';
import 'package:todo_list_app/base/base_store.dart';
import 'package:todo_list_app/screen/todo_list/todo_list.state.dart';
import 'package:todo_list_app/services/todo_list/models.dart';

class StartTodoList extends StoreAction {}

class CheckTodoList extends StoreAction {
  final int index;

  CheckTodoList({@required this.index});
}

class TodoListPageStore extends BaseStore<TodoListPageState> {
  TodoListPageStore() : super(TodoListPageState());

  @override
  void dispatch(StoreAction action) async {
    if (action is StartTodoList) {
      await _startList();
    } else if (action is CheckTodoList) {
      await _checkTodoList(action);
    }
  }

  Future _startList() async {
    List<ListInfo> todoList = [];
    for (int i = 1; i < 6; i++) {
      todoList
          .add(ListInfo(description: 'Test Saved Stop No: $i', checked: false));
    }
    updateState(currentState.copyWith(
      todoList: todoList,
    ));
  }

  Future _checkTodoList(CheckTodoList action) async {
    List<ListInfo> todoList = currentState.todoList;
    if (todoList[action.index].checked) {
      todoList[action.index].checked = false;
    } else {
      todoList[action.index].checked = true;
    }
    updateState(currentState.copyWith(
      todoList: todoList,
    ));
  }
}
