import 'package:crm_software/home_page.dart';
import 'package:crm_software/login_page.dart';
import 'package:crm_software/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserPreference.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sales App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userToken = '';
  // String userId = '';

  void initState(){
    super.initState();
    userToken = UserPreference.getUserToken() ?? '';
    // setState(() {
    //   getUserData();
    // });
    // print(userToken);
  }

  // void getUserData() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //     if(userToken != null || userId != null){
  //       userToken = preferences.getString('user_token');
  //       userId = preferences.getString('user_id');
  //     }else{
  //       userToken = "";
  //       userId = "";
  //     }
  //     print(userToken);
  //     // print(userId);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userToken != '' ? HomePage() : LoginPage(),
    );
  }

}
