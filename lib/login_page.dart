import 'dart:convert';

import 'package:crm_software/gloabal_variable.dart';
import 'package:crm_software/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:crm_software/user_preference.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldkey,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.pink,
                    Colors.pink
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  height: 520,
                  width: double.infinity,
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      headerSection(),
                      textSection(),
                      formSection(),
                      buttonSection(),
                      footerSection(),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: HexColor('#efefef'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container headerSection() {
    return Container(
      child: Image.asset(
        'assets/images/logo.png',
        height: 60,
      ),
    );
  }

  Container textSection() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text('power of cutting edge artificial intelligence technology'.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                wordSpacing: 1
            ),
          ),
        ],
      ),
    );
  }

  Form formSection(){
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 10,),
            const SizedBox(height: 30.0,),
            txtEmail('Email', Icons.email),
            const SizedBox(height: 20.0,),
            txtPassword('Password', Icons.lock),
          ],
        ),
      ),
    );
  }

  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();

  TextFormField txtEmail(String title, IconData icon) {
    return TextFormField(
        controller: emailText,
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          suffixIcon: Icon(icon, color: Colors.black,),
          labelText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        validator: (value){
          if(value == null || value.isEmpty){
            return 'Please enter your email';
          }else{
            return null;
          }
        }
    );
  }

  TextFormField txtPassword(String title, IconData icon) {
    return TextFormField(
        controller: passwordText,
        cursorColor: Colors.black,
        obscureText: true,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          suffixIcon: Icon(icon, color: Colors.black,),
          labelText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        validator: (value){
          if(value == null || value.isEmpty){
            return 'Please enter your password';
          }else{
            return null;
          }
        }
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: const EdgeInsets.only(top: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {
        if(formKey.currentState!.validate()){
          SignIn();
        }
      },
        child: Text('Sign In'.toUpperCase(), style: TextStyle(color: Colors.white),),
        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
          backgroundColor: Colors.blueGrey,
        ),
      ),
    );
  }

  Container footerSection() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Image.asset('assets/images/crm-footer.png', width: 200,),
    );
  }


  void SignIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        }
    );
    var apiUrl = '$apiRootUrl/login_api.php';
    // print(apiUrl);
    var url = Uri.parse(apiUrl);
    var data = {
      "login_id": emailText.text,
      "password": passwordText.text
    };
    var request = jsonEncode(data);

    Response response = await http.post(
        url,
        body: request,
        headers: {
          "Content-type": "application/json"
        }
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
      var loginDataArr = jsonDecode(response.body);
      // print(loginDataArr);
      if(loginDataArr['lstatus'] == '1'){
        await UserPreference.setUserToken(loginDataArr['jwt']);
        await UserPreference.setUserId(loginDataArr['userId']);
        await UserPreference.setUserName(loginDataArr['userName']);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage(tabIndex: 0,)), (
            Route<dynamic> route) => false);
      }else{
        Fluttertoast.showToast(
            msg: 'Wrong Email Or Password',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0
        );
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Incorrect api url',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20.0
      );
    }

  }


}
