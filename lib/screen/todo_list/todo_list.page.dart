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
                              onPressed: () {},
                            )),
                      ),
                    ],
                  ),
                  body: Column(
                    children: <Widget>[
                      ExpansionTile(
                        title: Text("All",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                        children: <Widget>[
                          _TodoList(
                              listInfo: store.currentState.todoList,
                              store: store),
                        ],
                      ),
                    ],
                  ),
                )));
  }
}

class _TodoList extends StatelessWidget {
  _TodoList({Key key, this.listInfo, this.store}) : super(key: key);

  final ScrollController _scrollController = ScrollController();
  final List<ListInfo> listInfo;
  final TodoListPageStore store;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: this.listInfo.length,
        itemBuilder: (context, index) => _Item(
            index: index,
            desc: listInfo[index].description,
            checked: listInfo[index].checked,
            store: store));
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
    return ListTile(
      leading: icon,
      title: Align(
        alignment: Alignment(-0.8, 2),
        child: Text(this.desc),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
    );
  }
}
