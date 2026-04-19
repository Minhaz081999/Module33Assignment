import 'package:flutter/cupertino.dart';

class ColorPickerProvider extends ChangeNotifier{
  String? _selectedColor;

  String? get selectedColor => _selectedColor;
  // at first " Initialize value " through " init state function "
  set setColor(String value) {
    _selectedColor = value;
  }

  // after Click then " function call " to change " value of variable "
  void updateColor(String color) {
    _selectedColor = color;
    // এটিই ম্যাজিক লাইন, যা সব উইজেটকে বলে দেয় যে ডাটা চেঞ্জ হয়েছে
    notifyListeners();
  }

}