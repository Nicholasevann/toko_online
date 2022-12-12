import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toko_online/routes/bottom_navigation.dart';
import 'package:toko_online/screens/checkout.screen.dart';
import 'package:toko_online/screens/detailsearch_screen.dart';
import 'package:toko_online/screens/home_screen.dart';
import 'package:toko_online/screens/login_screen.dart';
import 'package:toko_online/screens/signup_screen.dart';
import 'package:toko_online/screens/splash_screen.dart';
import 'package:toko_online/screens/test.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/home': (context) => BottomNavigation(),
        '/checkout': (context) => Checkout(),
        '/test': (context) => Test(),
      },
    );
  }
}
