import 'package:flutter/cupertino.dart';

class MainNavProvider extends ChangeNotifier{

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setIndex( int currentIndex ){
    _selectedIndex = currentIndex;
    notifyListeners();
  }
  void backToHome(){
    setIndex(0);
    notifyListeners();
  }
  void moveToCategory(){
    setIndex(1);
    notifyListeners();
  }
}