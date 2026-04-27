import 'package:crafty_bay/app/app_theme.dart';
import 'package:crafty_bay/app/providers/localization_provider.dart';
import 'package:crafty_bay/app/providers/theme_provider.dart';
import 'package:crafty_bay/app/routes.dart';
import 'package:crafty_bay/features/auth/presentation/providers/otp_timer_provider.dart';
import 'package:crafty_bay/features/auth/presentation/screens/splash_screen.dart';
import 'package:crafty_bay/features/home/presentation/providers/home_slider_provider.dart';
import 'package:crafty_bay/features/product/presentation/providers/color_picker_provider.dart';
import 'package:crafty_bay/features/shared/presentation/providers/category_list_provider.dart';
import 'package:crafty_bay/features/shared/presentation/providers/main_nav_provider.dart';
import 'package:crafty_bay/features/shared/presentation/screens/main_nav_holder_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';


import '../features/product/presentation/providers/size_picker_provider.dart';
import '../l10n/app_localizations.dart';
import 'app_colors.dart';


class CraftyBayApp extends StatelessWidget {
  const CraftyBayApp({super.key});

  static GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [                           // object create         // function() call
        ChangeNotifierProvider(create: (_) => LocalizationProvider()..loadLocale() ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()..loadThemeMode() ),
        ChangeNotifierProvider(create: (_) => OtpTimerProvider() ),
        ChangeNotifierProvider(create: (_) => MainNavProvider() ),
        ChangeNotifierProvider(create: (_) => ColorPickerProvider() ),
        ChangeNotifierProvider(create: (_) => SizePickerProvider() ),
        ChangeNotifierProvider(create: (_) => HomeSliderProvider() ),
        ChangeNotifierProvider(create: (_) => CategoryListProvider() ),


      ],
      child: Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, _) {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'CraftyBayApp',
                // ----- Routes -----
                navigatorKey: navigatorkey,
                initialRoute: SplashScreen.name,
                onGenerateRoute: Routes.onGenerateRoute,
                // --------- ThemeMode ----------
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeProvider.themeMode,
                // Localization
                localizationsDelegates: [
                  AppLocalizations.delegate, // Add this line
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: localizationProvider.supportedLocales,
                // locale: Locale('en'),
                 locale: localizationProvider.locale,
              );
            }
          );
        }
      ),
    );
  }
}
