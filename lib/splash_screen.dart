import 'dart:async';

import 'package:crm_software/home_page.dart';
import 'package:crm_software/main.dart';
import 'package:flutter/material.dart';

import 'landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LandingPage(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(child: Image.asset('assets/images/salesapp.png', width: 200)),
        // child: Center(child: Text('SalesApp', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        );
    //   ),
    // );
  }
}
