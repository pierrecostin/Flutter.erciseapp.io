import 'package:exemple2/app_ecrans/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

void main() => {Stetho.initialize(), runApp(MyApp())};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF200087), fontFamily: 'Actor'),
      home: ProfileScreen(),
    );
  }
}
