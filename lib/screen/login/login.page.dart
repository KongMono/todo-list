import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/screen/login/login.store.dart';
import 'package:todo_list_app/services/login/models.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color _buttonColor = Colors.green;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _showDialog(BuildContext context) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text('Todo List'),
      content: Text('user or password incorrect'),
      actions: [
        CupertinoDialogAction(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          var store = LoginPageStore();
          store.dispatch(UpdateLogin());
          return store;
        },
        child: Consumer<LoginPageStore>(
            builder: (context, store, _) => Scaffold(
                  appBar: null,
                  body: Column(children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 80.0, bottom: 40),
                          child: Text('Login',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30)),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 40.0, right: 40.0, top: 10.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: CupertinoTextField(
                                controller: emailController,
                                placeholder: "Email",
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 40.0, right: 40.0, top: 10.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: CupertinoTextField(
                                obscureText: true,
                                controller: passwordController,
                                placeholder: "Password",
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 30.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: new RaisedButton(
                              color: _buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: new Text(
                                'Login',
                                textAlign: TextAlign.center,
                                style: new TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                // if (this.emailController.text ==
                                //         "test@test.com" &&
                                //     this.passwordController.text == "123456") {
                                //   Navigator.popAndPushNamed(
                                //       context, "/todo_list");
                                // } else {
                                //   _showDialog(context);
                                // }

                                Navigator.popAndPushNamed(
                                    context, "/todo_list");
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
                )));
  }
}
