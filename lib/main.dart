import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import 'global/constants/providers/providerslist.dart';
import 'global/constants/routes/routes.dart';
import 'global/constants/styles/colors/colors.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized(); 
 

  runApp(MultiProvider(providers: providersList,child:const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
  return  Platform.isIOS
            ? ScreenUtilInit(designSize: const Size(333,675),
              child: CupertinoApp(
                  title: 'Trading',
                
                  routes: routes,
                  initialRoute: '/',
                  theme: const CupertinoThemeData(
                      barBackgroundColor: kWhite, primaryColor: Colors.black),
                
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: const [
                      DefaultWidgetsLocalizations.delegate,
                      DefaultMaterialLocalizations.delegate,
                      DefaultCupertinoLocalizations.delegate
                    ]),
            )
            : ScreenUtilInit(designSize: const Size(333,675),child: MaterialApp(
                 routes: routes,
                title: 'Trading',
                initialRoute: '/',
               
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light().copyWith(
                  searchBarTheme: SearchBarThemeData(
                      backgroundColor: MaterialStateProperty.all(kWhite)),
                ))
                );
  }
}

