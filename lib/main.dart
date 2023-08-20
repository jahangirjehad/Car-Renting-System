import 'dart:async';
import 'package:car_renting_system/Login.dart';
import 'package:car_renting_system/Screen.dart';
import 'package:car_renting_system/addDriver.dart';
import 'package:car_renting_system/addcar.dart';
import 'package:car_renting_system/carOnTrip.dart';
import 'package:car_renting_system/carOwner.dart';
import 'package:car_renting_system/searchselected.dart';
import 'package:car_renting_system/update-car.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:car_renting_system/Myregister.dart';
import 'package:car_renting_system/Login.dart';
import 'package:car_renting_system/bottomnavbar.dart';
import 'package:car_renting_system/search.dart';

import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'mapping.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class Appcolors {
  static const Color blue = Color(0xEA0505FF);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            'register': (context) => const SignUp(),
            'login': (context) => const MyLogin(),
            'bottomNav': (context) => const BottomNavBar(),
            'search': (context) => const Search(),
            'carOwner': (context) => const CarOwner(),
            'add-car': (context) => const AddCar(),
            'add-driver': (context) => const AddDriver(),
            'update-car': (context) => const UpdateCar(),
            'car-on-trip': (context) => const CarOnTrip(),
          },
          title: 'First Method',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
