import 'dart:async';

import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:crafty_bay/features/auth/data/models/verify_otp_params.dart';
import 'package:crafty_bay/features/auth/presentation/providers/verify_otp_provider.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/app_logo.dart';
import 'package:crafty_bay/features/shared/presentation/screens/main_nav_holder_screen.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/center_progress_indicator.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/snack_bar_message.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/theme_switcher.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widgets/language_switcher.dart';
import '../widgets/resend_otp_section.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});

  static const String name = '/verify-otp';
  final String email;

  @override
  State<VerifyOtpScreen> createState() => VerifyOtpScreenState();
}

class VerifyOtpScreenState extends State<VerifyOtpScreen> {
  // variables
  final PinInputController _otpTEController = PinInputController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerifyOtpProvider _verifyOtpProvider = VerifyOtpProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _verifyOtpProvider,
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
                    Text('Enter OTP code', style: context.textTheme.titleLarge),
                    Text(
                      'A 4 digit code has been sent to your email address',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
      
                    const SizedBox(height: 24),
                    // Verify OTP Code -------------------------------------------
                    MaterialPinField(
                      length: 4,
                      pinController: _otpTEController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      theme: MaterialPinTheme(
                        shape: MaterialPinShape.outlined,
                        fillColor: Colors.transparent,
                        borderColor: AppColors.themeColor,
                        completeFillColor: Colors.transparent,
                        completeBorderColor: AppColors.themeColor,
                        spacing: 16,
                        cellSize: Size(50, 50),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // small button size
                    Consumer<VerifyOtpProvider>(
                      builder: (context,_,_) {
                        if(_verifyOtpProvider.verifyOtpInProgress){
                          return CenterProgressIndicator();
                        }
                        return FilledButton(
                          onPressed: onTapVerifyOtpButton,
                          child: Text('Verify'),
                        );
                      }
                    ),
                    const SizedBox(height: 16),
                    ResendOtpSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTapVerifyOtpButton() async{
    if (_otpTEController.text.length == 4) {
      VerifyOtpParams params = VerifyOtpParams(
        email: widget.email,
        otp: _otpTEController.text,
      );
      final bool isSuccess = await _verifyOtpProvider.verifyOtpIsSuccess(params);
      if(isSuccess){
        Navigator.pushNamedAndRemoveUntil(context, MainNavHolderScreen.name, (predicate)=> false);
      }else{
        showSnackBarMessage(context, _verifyOtpProvider.errorMessage!);
      }
    }
    // Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _otpTEController.dispose();
  }
}
