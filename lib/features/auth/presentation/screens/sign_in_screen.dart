import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:crafty_bay/app/validators.dart';
import 'package:crafty_bay/features/auth/data/models/sign_in_params.dart';
import 'package:crafty_bay/features/auth/presentation/providers/sign_in_provider.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/features/shared/presentation/screens/main_nav_holder_screen.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/center_progress_indicator.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/snack_bar_message.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/theme_switcher.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widgets/language_switcher.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // variables
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignInProvider _signInProvider = SignInProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _signInProvider,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppLogo(height: 100, width: 100),
                    const SizedBox(height: 16),
                    Text(
                      'Login to your account',
                      style: context.textTheme.titleLarge,
                    ),
                    Text(
                      'Sign In with your account details',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),

                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (value){
                        Validators.validateEmail(value);
                        },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (value){
                        Validators.validatePassword(value);
                      },
                    ),
                    const SizedBox(height: 8),
                    // small button size
                    Consumer<SignInProvider>(
                      builder: (context, _, _) {
                        if (_signInProvider.signInProgress) {
                          return const CenterProgressIndicator();
                        }
                        return FilledButton(
                          onPressed: _onTapSignInButton,
                          child: Text('Sign In'),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // small button size
                    TextButton(
                      onPressed: _onTapSignUpButton,
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapSignInButton() async {
    if (_formKey.currentState!.validate()) {
      SignInParams params = SignInParams(
        email: _emailTEController.text.trim(),
        password: _passwordTEController.text,
      );

      final bool isSuccess = await _signInProvider.signInIsSuccess(params);

      if(isSuccess){
        Navigator.pushNamedAndRemoveUntil(context,MainNavHolderScreen.name, (predicate)=> false);
      }else{
        showSnackBarMessage(context, _signInProvider.errorMessage!);
      }
      // Navigator.pop(context);
    }
  }
  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}
