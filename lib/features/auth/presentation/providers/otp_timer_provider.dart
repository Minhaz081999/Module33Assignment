import 'dart:async';

import 'package:flutter/cupertino.dart';

class OtpTimerProvider extends ChangeNotifier {

  Timer? _timer;
  int _start = 30;
  bool _showResendOtpButton = true;

  int get start => _start;
  bool get showResendOtpButton => _showResendOtpButton;

// 1) etake InitState() a call korte hoy
// 2) Resend Button a etake use korte hobe
  void startTimer(){
    _start = 30;
    _showResendOtpButton = false;
    notifyListeners();
    //----------- Timer set ------------------
    _timer = Timer.periodic(Duration(seconds: 1), (timer){
      if(_start == 0){
        timer.cancel();
        _showResendOtpButton = true;
       notifyListeners();
      }else{
        _start--;
        notifyListeners();
      }
    }
    );

  }

  void disposeTimer(){
    _timer?.cancel();
  }
//------------------------------------------------------------------------------

}