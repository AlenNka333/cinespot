import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/ui/root/home/home_view_model.dart';
import 'package:flutter/material.dart';

class TabBarViewModel extends ChangeNotifier {
  final AuthenticationManager _authManager;

  int _currentIndex = 0;
  int get getCurrentIndex => _currentIndex;

  //viewModels
  late final HomeViewModel homeViewModel;

  TabBarViewModel(this._authManager) {
    homeViewModel = HomeViewModel();
  }

  void setCurrentIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
