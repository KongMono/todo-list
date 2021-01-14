import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/screen/todo_list/todo_list.store.dart';
import 'package:todo_list_app/services/todo_list/models.dart';

class TodoListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  Color _buttonColor = Colors.green;
  TextEditingController textController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  _modalBottomSheetMenu(store) {
    showModalBottomSheet(
        isDismissible: false,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0))),
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
                                  height: 30,
                                  width: 70,
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text('Cancel',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center)))),
                          Expanded(
                              child: Container(
                                  height: 40, width: 40, child: null)),
                          new GestureDetector(
                              onTap: () {
                                store.dispatch(AddTodoList(
                                    listInfo: new ListInfo(
                                        description: textController.text,
                                        checked: false)));
                                Navigator.pop(context);
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 70,
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Text('Save',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center)))),
                        ],
                      ),
                      Divider(),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                              controller: textController,
                              decoration: new InputDecoration.collapsed(
                                  hintText: 'Task name...'),
                              autofocus: true)),
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                          child: Text('Due Date *',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center)),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoTextField(
                            obscureText: true,
                            placeholder: "วัน / เดือน / ปี พ.ศ.",
                          ))
                    ],
                  )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          var store = TodoListPageStore();
          store.dispatch(StartTodoList());
          return store;
        },
        child: Consumer<TodoListPageStore>(
            builder: (context, store, _) => Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    title: Text('To-do list',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500)),
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
                        title: Text("All",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        children: <Widget>[
                          _TodoList(
                              listInfo: store.currentState.todoList,
                              store: store)
                        ],
                      )
                    ],
                  )),
                )));
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
          return _Item(
              index: index,
              desc: listInfo[index].description,
              checked: listInfo[index].checked,
              store: store);
        });
  }
}

class _Item extends StatelessWidget {
  _Item({key, this.index, this.desc, this.checked, this.store})
      : super(key: key);

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
      text = Text(this.desc,
          style: TextStyle(decoration: TextDecoration.lineThrough));
    } else {
      text = Text(this.desc);
    }
    return text;
  }
}
