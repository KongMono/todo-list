import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/screen/todo_list/todo_list.store.dart';
import 'package:todo_list_app/services/todo_list/models.dart';
import 'package:intl/intl.dart';

class TodoListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  Color _buttonColor = Colors.green;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          var store = TodoListPageStore();
          store.dispatch(StartTodoList());
          store.dispatch(StartSelectedDate());
          return store;
        },
        child: Consumer<TodoListPageStore>(
            builder: (context, store, _) => Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    title: Text('To-do list', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: 70,
                            child: new RaisedButton(
                              color: _buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: new Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                store.dispatch(StartSelectedDate());
                                _modalBottomSheetMenu(store);
                              },
                            )),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      ExpansionTile(
                        backgroundColor: Colors.white,
                        title: Text("All", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                        children: <Widget>[_TodoList(listInfo: store.currentState.todoList, store: store)],
                      ),
                    ],
                  )),
                  bottomNavigationBar: BottomAppBar(
                    color: Colors.transparent,
                    child: new GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(context, "/");
                        },
                        child: Text('Log out',
                            style: TextStyle(height: 8.0, fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center)),
                    elevation: 0,
                  ),
                )));
  }

  _selectDate(BuildContext context, TodoListPageStore store) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: store.currentState.selectedDate.date,
        firstDate: DateTime(2000), // Required
        lastDate: DateTime(2025));
    if (picked != null && picked != store.currentState.selectedDate.date) {
      store.dispatch(UpdateSelectedDate(selectedDate: SelectedDate(date: picked, selected: true)));
    }
  }

  _changeFormatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(dateTime);

    String day = formatted.substring(0, 2);
    String month = formatted.substring(3, 5);
    String year = formatted.substring(6, 10);
    year = (int.parse(year) + 543).toString();

    return day + '/' + month + '/ ' + year;
  }

  _modalBottomSheetMenu(TodoListPageStore store) {
    showModalBottomSheet(
        isDismissible: false,
        shape: RoundedRectangleBorder(
            borderRadius:
                new BorderRadius.only(topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0))),
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return new GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: new Container(
                  height: 750.0,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          new GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: 70,
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: Text('Cancel',
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center)))),
                          Spacer(),
                          new GestureDetector(
                              onTap: () {
                                if (["", null, false, 0].contains(textController.text)) {
                                  return;
                                }
                                store.dispatch(AddTodoList(
                                    listInfo: new ListInfo(description: textController.text, checked: false)));
                                Navigator.pop(context);
                                textController.clear();
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: 70,
                                  child: Padding(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      child: Text('Save',
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center)))),
                        ],
                      ),
                      Divider(),
                      Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                              controller: textController,
                              decoration: new InputDecoration.collapsed(hintText: 'Task name...'),
                              autofocus: true)),
                      Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 15.0),
                          child: Text('Due Date *',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center)),
                      Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 8.0, right: 20.0),
                          child: SizedBox(
                              width: double.infinity,
                              child: new OutlineButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        store.currentState.selectedDate.selected
                                            ? _changeFormatDate(store.currentState.selectedDate.date)
                                            : 'วัน / เดือน / ปี พ.ศ.',
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left),
                                    Spacer(),
                                    Image(
                                      image: AssetImage('images/ico_calendar_green.png'),
                                      width: 20,
                                      height: 20,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  _selectDate(context, store);
                                },
                              )))
                    ],
                  )));
        });
  }
}

class _TodoList extends StatelessWidget {
  _TodoList({Key key, this.listInfo, this.store}) : super(key: key);
  final List<ListInfo> listInfo;
  final TodoListPageStore store;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: this.listInfo.length,
        itemBuilder: (context, index) {
          return _Item(index: index, desc: listInfo[index].description, checked: listInfo[index].checked, store: store);
        });
  }
}

class _Item extends StatelessWidget {
  _Item({key, this.index, this.desc, this.checked, this.store}) : super(key: key);

  final int index;
  final String desc;
  final bool checked;
  final TodoListPageStore store;

  @override
  Widget build(BuildContext context) {
    var icon;
    var text;
    icon = checkedImage(icon);
    text = checkedLineThrough(text);
    return Column(children: <Widget>[
      ListTile(
        leading: icon,
        title: Align(
          alignment: Alignment(-1.06, 2),
          child: text,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
      )
    ]);
  }

  checkedImage(icon) {
    if (this.checked) {
      icon = RaisedButton(
        onPressed: () {
          store.dispatch(CheckTodoList(index: this.index));
        },
        color: Colors.green,
        child: Image(
          image: AssetImage('images/checkmark.png'),
          width: 20,
          height: 20,
        ),
        shape: CircleBorder(),
      );
    } else {
      icon = OutlineButton(
        onPressed: () {
          store.dispatch(CheckTodoList(index: this.index));
        },
        color: Colors.green,
        child: null,
        shape: CircleBorder(),
      );
    }
    return icon;
  }

  checkedLineThrough(text) {
    if (this.checked) {
      text = Text(this.desc, style: TextStyle(decoration: TextDecoration.lineThrough));
    } else {
      text = Text(this.desc);
    }
    return text;
  }
}
