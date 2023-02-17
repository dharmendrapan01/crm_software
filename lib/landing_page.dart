import 'package:crm_software/user_preference.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String userToken = '';
  @override
  void initState(){
    super.initState();
    userToken = UserPreference.getUserToken() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userToken == '' ? LoginPage() : HomePage(tabIndex: 0,),
    );
  }
}
