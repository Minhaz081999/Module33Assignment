import 'package:crafty_bay/app/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';

class MainNavProvider extends ChangeNotifier{

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  Future<void> setIndex( int currentIndex ) async{


    _selectedIndex = currentIndex;
    notifyListeners();
  }

  bool shouldCheckIfUserLoggedIn(int index) => index == 2 || index == 3;

  void backToHome(){
    setIndex(0);
    notifyListeners();
  }
  void moveToCategory(){
    setIndex(1);
    notifyListeners();
  }
}