import 'package:flutter/material.dart';
import 'constants/app_constants.dart';
import 'dashboard/screens/splash/splash_screen.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: AppConstants.appName,
        theme: AppConstants.lightTheme(context),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen() //HistoryEmptyScreen() // PrescriptionEmptyScreen(  )//  ClinicalEmptyScreen()//SplashScreen() //OptionScreen()//HomeScreen() //EncounterExaminationsScreen()//ClinicalVisitPage()////PrescriptionPage()  //OptionScreen() //HomeScreen(),
        );
  }
}
