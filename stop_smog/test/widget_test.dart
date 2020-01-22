// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stop_smog/Auth/UI/Screens/home.dart';
import 'package:stop_smog/Auth/UI/Screens/sign_in.dart';
import 'package:stop_smog/Auth/UI/Widgets/loading.dart';
import 'package:stop_smog/Splash_Screen.dart';
import 'package:stop_smog/app_localizations.dart';
import 'package:stop_smog/main.dart';

void main() {
//  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(MyApp());
//
//    // Verify that our counter starts at 0.
//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);
//
//    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();
//
//    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);
//  });
//
  testWidgets('HomePage widgets test', (WidgetTester tester) async {
    final appBarTest = new AppBar(
      title: Text("Let's Stop Smog Now!"),
      backgroundColor: Colors.transparent,
      centerTitle: true,
    );
    final containerTest = Container(
        decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/back5.png"),
        fit: BoxFit.cover,
      ),
    ));
    final iconTest = Icon(
      Icons.movie,
      color: Colors.black,
      size: 30.0,
    );
    final cardTest = Card(
        child: ListTile(
      leading: Icon(
        Icons.thumbs_up_down,
        color: Colors.lightGreen,
        size: 30.0,
      ),
      title: Text('Quiz'),
    ));
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 100.0,
          child: ClipPath(
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
              width: 280.0,
              height: 250.0,
            ),
          )),

    );
    var app = new MaterialApp(
      home: new Material(
        child: SignInScreen()
      ),
      supportedLocales: [Locale('en', 'US'), Locale('pl', 'PL')],
      locale: Locale('en', 'US'),
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
    );
    var myApp = MyApp();
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    expect(find.text("Forgot Password"), findsWidgets);
    expect(find.text("Create Account"), findsWidgets);
  });
}
