import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stop_smog/Devices/Device_menu.dart';
import 'package:stop_smog/Devices/Device_page.dart';
import 'package:stop_smog/Infographic/Infographic_Page.dart';
import 'package:stop_smog/home_page.dart';

import 'Auth/UI/Screens/forgot_password.dart';
import 'Auth/UI/Screens/home.dart';
import 'Auth/UI/Screens/sign_in.dart';
import 'Auth/UI/Screens/sign_up.dart';
import 'Auth/UI/theme.dart';
import 'Auth/Util/state_widget.dart';
import 'Blog/Blog_menu_page.dart';
import 'Blog/Post_page.dart';
import 'Post/New_point_steps.dart';
import 'Post/Param_history.dart';
import 'Post/StationList_Filter.dart';
import 'Post/Station_List.dart';
import 'Post/Station_details.dart';
import 'Quiz/Quiz_page.dart';
import 'Splash_Screen.dart';
import 'Video/Youtube_player.dart';
import 'app_localizations.dart';

void main() {
  StateWidget stateWidget = new StateWidget(
    child: new MyApp(),
  );
  runApp(stateWidget);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      theme: ThemeData(
//        primarySwatch: Colors.grey,
//        accentColor: Colors.grey[100],
//        canvasColor: Colors.grey[100],
//        fontFamily: 'Raleway',
//      ),
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
        home: SplashScreen(), //TO POKAZUJE NAJGŁOWNIEJSZY PAGE!
        routes: {
          '/': (context) => HomeScreen(),
          '/signin': (context) => SignInScreen(),
          '/signup': (context) => SignUpScreen(),
          '/forgot-password': (context) => ForgotPasswordScreen(),
          // '/': (ctx) =>HomePage(), //TO POKAZUJE NAJGŁOWNIEJSZY PAGE!
          BlogMenuPage.routeName: (ctx) => BlogMenuPage(),
          PostPage.routeName: (ctx) => PostPage(),
          DeviceMenuPage.routeName: (ctx) => DeviceMenuPage(),
          DevicePage.routeName: (ctx) => DevicePage(),
          HomePage.routeName: (ctx) => HomePage(),
          QuizPage.routeName: (ctx) => QuizPage(),
          YoutubePlayerPage.routeName: (ctx) => YoutubePlayerPage(),
          StationListScreen.routeName: (ctx) => StationListScreen(),
          NewPointSteps.routeName: (ctx) => NewPointSteps(),
          StationDetails.routeName: (ctx) => StationDetails(),
          InfographicPage1.routeName: (ctx) => InfographicPage1(),
          InfographicPage2.routeName: (ctx) => InfographicPage2(),
          InfographicPage3.routeName: (ctx) => InfographicPage3(),
          StationFilter.routeName: (ctx) => StationFilter()
        });
  }
}
