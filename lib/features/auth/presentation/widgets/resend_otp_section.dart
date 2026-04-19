import 'dart:async';

import 'package:crafty_bay/features/auth/presentation/providers/otp_timer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';


class ResendOtpSection extends StatefulWidget {
  const ResendOtpSection({
    super.key,
  });

  @override
  State<ResendOtpSection> createState() => _ResendOtpSectionState();
}

class _ResendOtpSectionState extends State<ResendOtpSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask((){
      context.read<OtpTimerProvider>().startTimer();
    });

  }


  @override
  Widget build(BuildContext context) {
   // For variable calling
   OtpTimerProvider pWatch = context.watch<OtpTimerProvider>();

    return Column(
      children: [
        if(!pWatch.showResendOtpButton) // NOT (!) false => true
          RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: Colors.black54
                  ),
                  children:[
                    TextSpan(text: 'You can otp resend after '),
                    TextSpan(
                        text: '${pWatch.start} s',
                        style: TextStyle(
                            color: AppColors.themeColor,
                            fontWeight: .w600

                        )
                    )

                  ]
              )
          ),
        // small button size
        if(pWatch.showResendOtpButton) // true
          TextButton(onPressed: _onTapSignUpButton, child: Text('Resend OTP'))
      ],
    );
  }

  void _onTapSignUpButton(){
    // For function calling
    context.read<OtpTimerProvider>().startTimer();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // For function calling
    context.read<OtpTimerProvider>().disposeTimer();
  }

}