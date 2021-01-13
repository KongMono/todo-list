import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseStore<State> extends ChangeNotifier {
  State currentState;

  BaseStore(this.currentState);

  void updateState(State newState) {
    currentState = newState;
    notifyListeners();
  }

  void dispatch(StoreAction action);
}

class StoreAction {}

class StoreEvent {}