import 'package:todo_list_app/base/base_store.dart';
import 'package:todo_list_app/screen/login/login.state.dart';
import 'package:todo_list_app/services/login/models.dart';
import 'package:todo_list_app/services/todo_list/models.dart';

class UpdateLogin extends StoreAction {}

class LoginPageStore extends BaseStore<LoginPageState> {
  LoginPageStore() : super(LoginPageState());

  @override
  void dispatch(StoreAction action) async {
    if (action is UpdateLogin) {
      await _updateLogin();
    }
  }

  Future _updateLogin() async {
    UserInfo user = UserInfo(username: '', password: '');

    updateState(currentState.copyWith(
      user: user,
    ));
  }
}
