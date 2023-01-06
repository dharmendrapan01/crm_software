import 'package:crm_software/home_page.dart';
import 'package:flutter/material.dart';

import '../login_page.dart';
import '../main.dart';
import '../user_preference.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Container(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage(tabIndex: 0,)), (Route<dynamic> route) => false);
              },
                child: Image.asset('assets/images/salesapp.png', width: 100),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text('Live Call'.toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  SizedBox(width: 3,),
                  Icon(Icons.call),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            ElevatedButton(onPressed: () async {
              UserPreference.setUserToken('');
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()), (
                  Route<dynamic> route) => false);
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Row(
                children: [
                  Text('Log Out'.toUpperCase(), style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500,),),
                  SizedBox(width: 3,),
                  Icon(Icons.logout),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
