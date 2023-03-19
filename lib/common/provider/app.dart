import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  late bool _isGrayFilter;
  get isGrayFilter => _isGrayFilter;

  AppState({bool isGrayFilter = false}) {
    _isGrayFilter = isGrayFilter;
  }

  switchGrayFilter() {
    _isGrayFilter = !_isGrayFilter;
    notifyListeners();
  }
}
