import 'package:flutter/material.dart';

class TabBarViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get getCurrentIndex => _currentIndex;

  TabBarViewModel();

  void setCurrentIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
