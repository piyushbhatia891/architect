import 'package:architect/screens/add_project/index.dart';
import 'package:architect/screens/home/index.dart';
import 'package:architect/screens/login/index.dart';
import 'package:architect/screens/projects/index.dart';
import 'package:architect/screens/splash/index.dart';
import 'package:architect/services/drawing/DrawingViewModel.dart';
import 'package:architect/services/project/ProjectViewModel.dart';
import 'package:architect/services/markings/MarkingViewModel.dart';
import 'package:architect/shared/constants/constants.dart';
import 'package:architect/shared/router/routes.dart';
import 'package:architect/shared/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<DrawingViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<MarkingViewModel>()),
        ChangeNotifierProvider(create: (_) => locator<ProjectViewModel>()),
      ],
      child: MaterialApp(
        title: Constants.APP_NAME,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Routes.SPLASH,
        routes: {
          Routes.SPLASH:(context)=>SplashScreenPage(),
          Routes.LOGIN:(context)=>LoginPage(),
          Routes.HOME:(context)=>HomePage(),
          Routes.PROJECTS:(context)=>ProjectsPage(),
          Routes.ADD_PROJECTS:(context)=>AddProjectPage()
        },
      ),
    );
  }
}