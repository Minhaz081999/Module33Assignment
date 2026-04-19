import 'package:flutter/cupertino.dart';

class SizePickerProvider extends ChangeNotifier{
  String? _selectedSize;

  String? get selectedSize => _selectedSize;
  // at first " Initialize value " through " init state function "
  set setSize(String value) {
    _selectedSize = value;
  }

  // after Click then " function call " to change " value of variable "
  void updateSize(String color) {
    _selectedSize = color;
    // এটিই ম্যাজিক লাইন, যা সব উইজেটকে বলে দেয় যে ডাটা চেঞ্জ হয়েছে
    notifyListeners();
  }

}