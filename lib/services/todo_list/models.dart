import 'package:flutter/widgets.dart';

class ListInfo {
  String description;
  bool checked;

  ListInfo({
    @required this.description,
    @required this.checked
  });
}

class SelectedDate {
  DateTime date;
  bool selected;

  SelectedDate({
    @required this.date,
    @required this.selected
  });
}