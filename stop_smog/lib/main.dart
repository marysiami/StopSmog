import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stop_smog/Devices/Device_menu.dart';
import 'package:stop_smog/Devices/Device_page.dart';
import 'package:stop_smog/Infographic/Infographic_Page.dart';
import 'Auth/UI/Screens/forgot_password.dart';
import 'Auth/UI/Screens/home.dart';
import 'Auth/UI/Screens/sign_in.dart';
import 'Auth/UI/Screens/sign_up.dart';
import 'Auth/UI/theme.dart';
import 'Auth/Util/state_widget.dart';
import 'Blog/Blog_menu_page.dart';
import 'Blog/Post_page.dart';
import 'Post/New_point_steps.dart';
import 'Post/StationList_Filter.dart';
import 'Post/Station_List.dart';
import 'Post/Station_details.dart';
import 'Quiz/Quiz_page.dart';
import 'Quiz2/Quiz2Main.dart';
import 'Video/Youtube_player.dart';
import 'app_localizations.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Let's Stop Smog Now!",
        theme: buildTheme(),
        debugShowCheckedModeBanner: false,
        supportedLocales: [Locale('en', 'US'), Locale('pl', 'PL')],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        routes: {
          '/': (context) => HomeScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          '/signin': (context) => SignInScreen(),
          '/signup': (context) => SignUpScreen(),
          '/forgot-password': (context) => ForgotPasswordScreen(),
          BlogMenuPage.routeName: (context) => BlogMenuPage(),
          PostPage.routeName: (context) => PostPage(),
          DeviceMenuPage.routeName: (context) => DeviceMenuPage(),
          DevicePage.routeName: (context) => DevicePage(),
          QuizPage.routeName: (context) => QuizPage(),
          YoutubePlayerPage.routeName: (context) => YoutubePlayerPage(),
          StationListScreen.routeName: (context) => StationListScreen(),
          MyPoints.routeName: (context) => MyPoints(),
          StationDetails.routeName: (context) => StationDetails(),
          InfographicPage1.routeName: (context) => InfographicPage1(),
          StationFilter.routeName: (context) => StationFilter(),
          Quiz2Main.routeName: (context)=> Quiz2Main()
          //Quiz2
        });
  }
}

void main() {
  StateWidget stateWidget = new StateWidget(
    child: new MyApp(),
  );
  runApp(stateWidget);
}
