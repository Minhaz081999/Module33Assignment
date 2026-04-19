import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:crafty_bay/app/validators.dart';
import 'package:crafty_bay/features/auth/data/models/sign_up_params.dart';
import 'package:crafty_bay/features/auth/presentation/providers/sign_up_provider.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/app_logo.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widgets/center_progress_indicator.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // variables
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignUpProvider _signUpProvider = SignUpProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _signUpProvider,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    AppLogo(height: 100, width: 100),
                    const SizedBox(height: 16),
                    Text(
                      context.l10n.signUpTitle,
                      style: context.textTheme.titleLarge,
                    ),
                    Text(
                      context.l10n.signUpSubtitle,
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
                      validator: (String? value) {
                        Validators.validateEmail(value);
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _firstNameTEController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'First Name'),
                      validator: (String? value) {
                        Validators.validateNullOrEmpty(
                          value,
                          'Enter your first name',
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameTEController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'Last Name'),
                      validator: (String? value) {
                        Validators.validateNullOrEmpty(
                          value,
                          'Enter your last name',
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _phoneTEController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'Phone'),
                      validator: (String? value) {
                        Validators.validateNullOrEmpty(
                          value,
                          'Enter valid phone number',
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _cityTEController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'City'),
                      validator: (String? value) {
                        Validators.validateNullOrEmpty(
                          value,
                          'Enter valid city name',
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (String? value) {
                        Validators.validatePassword(value);
                      },
                    ),
                    const SizedBox(height: 8),
                    // small button size
                    Consumer<SignUpProvider>(
                      builder: (context, _, _) {
                        if (_signUpProvider.signUpInProgress) {
                          return CenterProgressIndicator();
                        }
                        return FilledButton(
                          onPressed: _onTapSignUpButton,
                          child: Text(context.l10n.signUp),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // small button size
                    TextButton(
                      onPressed: _onTapSignInButton,
                      child: Text('Sign In'),
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

  Future<void> _onTapSignUpButton() async {
    if (_formKey.currentState!.validate()) {
      SignUpParams params = SignUpParams(
        email: _emailTEController.text.trim(),
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        password: _passwordTEController.text,
        city: _cityTEController.text,
        phone: _phoneTEController.text,
      );

      final isSuccess = await  _signUpProvider.signUpIsSuccess(params); // return => True

      if(isSuccess){
        Navigator.pushNamed(context, VerifyOtpScreen.name, arguments: _emailTEController.text.trim());
      }else{
        showSnackBarMessage(context, _signUpProvider.errorMessage!);
      }
      
    }

  }

  void _onTapSignInButton() {
    Navigator.pushNamed(context, SignInScreen.name);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneTEController.dispose();
    _cityTEController.dispose();
    _passwordTEController.dispose();
  }
}
