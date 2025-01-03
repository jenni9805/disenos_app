import 'package:flutter/material.dart';

class SliderProvider with ChangeNotifier {
  double _currentPage = 0;
  double get currentPage => _currentPage;

  set currentPage(double value) {
    _currentPage = value;
    notifyListeners();
  }
}
