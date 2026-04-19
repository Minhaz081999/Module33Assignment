import 'package:crafty_bay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension UtilsExtension on BuildContext{

  // ------- variable/object of Localization -------
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  // ------- variable/object of TextTheme -------
  TextTheme get textTheme => TextTheme.of(this);
}