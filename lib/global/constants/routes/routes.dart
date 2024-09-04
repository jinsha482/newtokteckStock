import 'package:flutter/material.dart';
import 'package:trading/modules/splash/view/splash_screen.view.dart';
import '../../../modules/homescreen/view/home_screen.view.dart';


Map<String, Widget Function(BuildContext)> routes = {
  '/' : (BuildContext context) =>  const SplashScreen(),
  'home' : (BuildContext context) =>  const HomeScreen(),
   };