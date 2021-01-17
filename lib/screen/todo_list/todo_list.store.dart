import 'package:flutter/widgets.dart';
import 'package:todo_list_app/base/base_store.dart';
import 'package:todo_list_app/screen/todo_list/todo_list.state.dart';
import 'package:todo_list_app/services/todo_list/models.dart';

class UpdateSelectedDate extends StoreAction {
  final SelectedDate selectedDate;

  UpdateSelectedDate({@required this.selectedDate});
}

class StartSelectedDate extends StoreAction {}

class StartTodoList extends StoreAction {}

class AddTodoList extends StoreAction {
  final ListInfo listInfo;

  AddTodoList({@required this.listInfo});
}

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
    } else if (action is StartSelectedDate) {
      await _startSelectedDate();
    } else if (action is CheckTodoList) {
      await _checkTodoList(action);
    } else if (action is AddTodoList) {
      await _addTodoList(action);
    } else if (action is UpdateSelectedDate) {
      await _updateSelectedDate(action);
    }
  }

  Future _startList() async {
    List<ListInfo> todoList = [];
    updateState(currentState.copyWith(
      todoList: todoList,
    ));
  }

  Future _startSelectedDate() async {
    SelectedDate selectedDate = new SelectedDate(date: DateTime.now(), selected: false);
    updateState(currentState.copyWith(
      selectedDate: selectedDate,
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

  Future _addTodoList(AddTodoList action) async {
    List<ListInfo> todoList = currentState.todoList;
    todoList.insert(0, action.listInfo);
    updateState(currentState.copyWith(
      todoList: todoList,
    ));
  }

  Future _updateSelectedDate(UpdateSelectedDate action) async {
    SelectedDate selectedDate = currentState.selectedDate;
    selectedDate.date = action.selectedDate.date;
    selectedDate.selected = action.selectedDate.selected;
    updateState(currentState.copyWith(
      selectedDate: selectedDate,
    ));
  }
}
