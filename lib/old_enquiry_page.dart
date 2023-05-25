import 'dart:convert';

import 'package:crm_software/reminder_page.dart';
import 'package:crm_software/screen/all_enquiry_lead.dart';
import 'package:crm_software/screen/allold_enquiry.dart';
import 'package:crm_software/screen/menue_page.dart';
import 'package:crm_software/screen/olddeleted_enq.dart';
import 'package:crm_software/screen/oldnotmodify_enq.dart';
import 'package:crm_software/screen/oldqualify_enq.dart';
import 'package:crm_software/screen/oldstatusunkn_enq.dart';
import 'package:crm_software/user_preference.dart';
import 'package:crm_software/whatsapp_page.dart';
import 'package:crm_software/widgets/bottom_menue.dart';
import 'package:crm_software/widgets/header_first.dart';
import 'package:crm_software/widgets/header_section.dart';
import 'package:crm_software/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'gloabal_variable.dart';
import 'home_page.dart';
import 'newlead_page.dart';

class OldEnquiryPage extends StatefulWidget {
  final tabIndex;
  const OldEnquiryPage({Key? key, this.tabIndex}) : super(key: key);

  @override
  State<OldEnquiryPage> createState() => _OldEnquiryPageState();
}

class _OldEnquiryPageState extends State<OldEnquiryPage> with TickerProviderStateMixin {
  String tabcount1 = '0';
  String tabcount2 = '0';
  String tabcount3 = '0';
  String tabcount4 = '0';
  String tabcount5 = '0';
  String? userToken = '';
  String? userId = '';

  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    getCountVal(userToken, userId);
    super.initState();
  }

  // int _selectedIndex = -1;
  // void onItemTaped(int index){
  //   setState(() {
  //     _selectedIndex = index;
  //     if(_selectedIndex == 0){
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(tabIndex: 0)));
  //     }else if(_selectedIndex == 1){
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ReminderPage(tabIndex: 0)));
  //     }else if(_selectedIndex == 2){
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MenuePage()));
  //     }else if(_selectedIndex == 3){
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WhatsappPage()));
  //     }else if(_selectedIndex == 4){
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NewleadPage()));
  //     }
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        elevation: 0,
        toolbarHeight: 45.0,
        backgroundColor: Colors.white,
        // leadingWidth: 2.0,
        flexibleSpace: SafeArea(
          child: HeaderFirst(),
        ),
      ),
      drawer: MyDrawer(),
      body: Container(
        height: double.maxFinite,
        child: ListView(
          children: [
            HeaderSection(),
            bodySection(widget.tabIndex),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }



  // Container topHeaderBar() {
  //   return Container(
  //     color: Colors.black,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         SizedBox(width: 40,),
  //         Image.asset('assets/images/salesapp.png', width: 100),
  //         Padding(
  //           padding: const EdgeInsets.only(right: 3.0),
  //           child: ElevatedButton(
  //             onPressed: () {},
  //             child: Row(
  //               children: [
  //                 Text('Live Call'.toUpperCase(),
  //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
  //                 SizedBox(width: 3,),
  //                 Icon(Icons.call),
  //               ],
  //             ),
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.green,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }


  Container bodySection(tabIndex) {
    TabController _tabController = TabController(
        length: 5, initialIndex: tabIndex == null ? tabIndex = 0 : tabIndex = tabIndex, vsync: this
    );
    return Container(
      height: MediaQuery.of(context).size.height * 0.81,
      child: Column(
        children: [
          // SizedBox(height: 5,),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.orange,
                ),
                controller: _tabController,
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                tabs: [
                  Tab(child: Text('Not Modify (${tabcount1})', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('Status Unknown (${tabcount2})', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('Qualified (${tabcount3})', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('Deleted (${tabcount4})', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('All Old (${tabcount5})', style: TextStyle(color: Colors.black),),),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                OldNotModifyEnq(),
                OldStatusUnknEnq(),
                OldQualifyEnq(),
                OldDeletedEnq(),
                AllOldEnquiry(),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // Widget bottomMenue(BuildContext context) {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
  //     child: BottomNavigationBar(
  //       type: BottomNavigationBarType.fixed,
  //       backgroundColor: Colors.black12,
  //       currentIndex: _selectedIndex == -1 ? 0 : _selectedIndex,
  //       selectedItemColor: _selectedIndex == -1 ? Colors.grey : Colors.orange,
  //       unselectedItemColor: Colors.grey,
  //       showUnselectedLabels: true,
  //       elevation: 0,
  //       items: [
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.call, color: Colors.green,),
  //           label: 'Calls',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.notifications_active_rounded, color: Colors.red,),
  //           label: 'Reminder',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home, color: Colors.black,),
  //           label: 'Home',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green,),
  //           label: 'Whatsapp',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.filter_alt, color: Colors.red,),
  //           label: 'New Lead',
  //         ),
  //       ],
  //       onTap: onItemTaped,
  //     ),
  //   );
  // }

  void getCountVal(userToken, userId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/oldenquirycount.php?user_id=$userId'),
        headers: headersData);
    var responseArr = jsonDecode(response.body);
    setState(() {
      tabcount1 = responseArr['tabcount1'];
      tabcount2 = responseArr['tabcount2'];
      tabcount3 = responseArr['tabcount3'];
      tabcount4 = responseArr['tabcount4'];
      tabcount5 = responseArr['tabcount5'];
    });
  }


}
