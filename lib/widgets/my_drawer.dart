import 'package:crm_software/data_enquiry_page.dart';
import 'package:crm_software/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../alldeleted_page.dart';
import '../closerpipeline_page.dart';
import '../freshenquiry_page.dart';
import '../login_page.dart';
import '../meeting_page.dart';
import '../miised_followup.dart';
import '../nqdelete_page.dart';
import '../qualified_delete_page.dart';
import '../qualified_page.dart';
import '../screen/allenquiry_lead.dart';
import '../screen/menue_page.dart';
import '../sitevisit_page.dart';
import '../status_unknwn_page.dart';
import '../user_preference.dart';
import '../verge_closer_page.dart';
import '../whatsapp_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          drawerHeader(context),
          drawerMenueItems(context),
        ],
      ),
    );
  }

  Widget drawerHeader(BuildContext context) {
    return Material(
      color: Colors.green,
      elevation: 5,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(
            top: 10 + MediaQuery.of(context).padding.top, bottom: 24,
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Image.asset('assets/images/default.png', width: 100),
            ),
            SizedBox(height: 12.0,),

            Text('Dharmendra Pandey', style: TextStyle(fontSize: 28.0, color: Colors.white),),
            Text('info@propertyxpo.com', style: TextStyle(fontSize: 16.0, color: Colors.white),),
          ],
        ),
      ),
    );
  }

  Widget drawerMenueItems(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView(
          padding: EdgeInsets.only(top: 0.0, left: 20.0),
          children: [
            ListTile(
              leading: Icon(Icons.home, color: Colors.green, size: 30.0,),
              title: Text('Home', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MenuePage()));
              },
            ),

            // SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            // ListTile(
            //   leading: FaIcon(Icons.account_box, color: Colors.green, size: 30.0,),
            //   title: Text('Admin', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
            //   onTap: (){},
            // ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(Icons.list, color: Colors.green, size: 30.0,),
              title: Text('All Enquiry', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllenquiryLead(tabIndex: 0)));
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(Icons.library_books, color: Colors.green, size: 30.0,),
              title: Text('Fresh Enquiry', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FreshEnquiryPage(tabIndex: 0)));
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(Icons.event_note, color: Colors.green, size: 30.0,),
              title: Text('Data Enquiry', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DataEnquiryPage(tabIndex: 0)));
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(Icons.thumb_up, color: Colors.green, size: 30.0,),
              title: Text('Qualified', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => QualifiedPage(tabIndex: 0)));
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(Icons.question_mark, color: Colors.green, size: 30.0,),
              title: Text('Status Unknown', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => StatusUnknPage(tabIndex: 0)));
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(Icons.rule, color: Colors.green, size: 30.0,),
              title: Text('Closure Pipline', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CloserPipeLinePage()));
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(Icons.credit_score, color: Colors.green, size: 30.0,),
              title: Text('Verge Of Closure', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => VergeCloserPage()));
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(Icons.people, color: Colors.green, size: 30.0,),
              title: Text('Site Visit', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SiteVisitPage(tabIndex: 0)));
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(Icons.groups, color: Colors.green, size: 30.0,),
              title: Text('Meeting', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MeetingPage(tabIndex: 0)));
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(Icons.phone_missed, color: Colors.red, size: 30.0,),
              title: Text('Missed Followup', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MissedFollowup()));
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 30.0,),
              title: Text('Whatsapp', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WhatsappPage()));
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(Icons.delete, color: Colors.green, size: 30.0,),
              title: Text('Qualified Delete', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => QualifiedDeletePage()));
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(Icons.delete_outline, color: Colors.green, size: 30.0,),
              title: Text('Not Qualify Delete', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotQualDeletePage()));
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(Icons.delete_forever, color: Colors.green, size: 30.0,),
              title: Text('Delete', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDeletedPage()));
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

            ListTile(
              leading: FaIcon(Icons.logout, color: Colors.green, size: 30.0,),
              title: Text('Logout', style: TextStyle(fontSize: 18.0, color: Colors.black54, fontWeight: FontWeight.bold),),
              onTap: (){
                UserPreference.setUserToken('');
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()), (
                    Route<dynamic> route) => false);
              },
            ),

            SizedBox(child: Container(height: 1.0, color: Colors.green,),),

          ],
        ),
      ),
    );
  }

  
}
