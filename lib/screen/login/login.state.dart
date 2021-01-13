import 'package:todo_list_app/services/login/models.dart';

class LoginPageState {
  final UserInfo user;

  LoginPageState({
    this.user = const UserInfo(username: '', password: ''),
  });

  LoginPageState copyWith({UserInfo user}) {
    return LoginPageState(
      user: user ?? this.user
    );
  }
}
