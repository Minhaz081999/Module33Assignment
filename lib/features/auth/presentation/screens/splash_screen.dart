
import 'package:crafty_bay/app/controllers/auth_controller.dart';
import 'package:crafty_bay/features/auth/presentation/screens/withoutConst.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:crafty_bay/features/shared/presentation/screens/main_nav_holder_screen.dart';
import 'package:flutter/material.dart';


import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _moveToNextScreen();

  }
// short cut reformate keys : ctrl + alt + L
  Future<void> _moveToNextScreen() async {
    // wait 5 seconds in this Splash Screen
    await Future.delayed(Duration(seconds: 5));
    // get user information if store in Local Memory
    await AuthController.loadUserData();
    // ----- Move to next page -----
    // Navigator.pushReplacementNamed(context, SignUpScreen.name);
    Navigator.pushReplacementNamed(context, SignUpScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                  child: AppLogo()
              ),
              CircularProgressIndicator(),

            ],
          ),
        ),
      ),
    );
  }
}


