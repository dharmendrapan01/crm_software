import 'dart:convert';

import 'package:crm_software/screen/allqualified_lead.dart';
import 'package:crm_software/screen/cold_lead.dart';
import 'package:crm_software/screen/hot_lead.dart';
import 'package:crm_software/screen/qualified_data.dart';
import 'package:crm_software/screen/qualified_fresh.dart';
import 'package:crm_software/screen/qualified_old.dart';
import 'package:crm_software/user_preference.dart';
import 'package:crm_software/widgets/bottom_menue.dart';
import 'package:crm_software/widgets/header_first.dart';
import 'package:crm_software/widgets/header_section.dart';
import 'package:crm_software/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'gloabal_variable.dart';

class QualifiedPage extends StatefulWidget {
  final tabIndex;
  const QualifiedPage({Key? key, this.tabIndex}) : super(key: key);

  @override
  State<QualifiedPage> createState() => _QualifiedPageState();
}

class _QualifiedPageState extends State<QualifiedPage> with TickerProviderStateMixin {
  String tabcount1 = '0';
  String tabcount2 = '0';
  String tabcount3 = '0';
  String tabcount4 = '0';
  String tabcount5 = '0';
  String tabcount6 = '0';
  String? userToken = '';
  String? userId = '';

  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    getCountVal(userToken, userId);
    super.initState();
  }

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


  Container bodySection(tabIndex) {
    TabController _tabController = TabController(
        length: 6, initialIndex: tabIndex == null ? tabIndex = 0 : tabIndex = tabIndex, vsync: this
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
                  Tab(child: Text('Qualified Lead (${tabcount1})', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('Hot Lead (${tabcount2})', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('Cold Lead (${tabcount3})', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('Qualified Fresh (${tabcount4})', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('Qualified Data (${tabcount5})', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('Qualified Old (${tabcount6})', style: TextStyle(color: Colors.black),),),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AllQualifiedLead(),
                HotLead(),
                ColdLead(),
                QualifiedFresh(),
                QualifiedDataLead(),
                QualifiedOld(),
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

  // void getCountVal(userToken, userId) async {
  //   var headersData = {
  //     "Content-type": "application/json",
  //     "Authorization": "Bearer $userToken"
  //   };
  //   var response = await http.get(
  //       Uri.parse(
  //           '$apiRootUrl/qualifiedcount.php?user_id=$userId'),
  //       headers: headersData);
  //   var responseArr = jsonDecode(response.body);
  //   setState(() {
  //     tabcount1 = responseArr['tabcount1'];
  //     tabcount2 = responseArr['tabcount2'];
  //     tabcount3 = responseArr['tabcount3'];
  //     tabcount4 = responseArr['tabcount4'];
  //     tabcount5 = responseArr['tabcount5'];
  //     tabcount6 = responseArr['tabcount6'];
  //   });
  // }


  Future getCountVal(userToken, userId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/qualifiedcount.php';
    var url = Uri.parse(apiUrl);

    var data = {
      "user_id": userId,
      "switch_user": filterUsers,
      "switch_source": filterSource,
      "switch_child": filterParentChild,
      "switch_leadtype": filterLeadType
    };
    var request = jsonEncode(data);
    http.Response response = await http.post(
        url,
        body: request,
        headers: headersData
    );
    var responseArr = jsonDecode(response.body);
    if (this.mounted) {
      setState(() {
        tabcount1 = responseArr['tabcount1'];
        tabcount2 = responseArr['tabcount2'];
        tabcount3 = responseArr['tabcount3'];
        tabcount4 = responseArr['tabcount4'];
        tabcount5 = responseArr['tabcount5'];
        tabcount6 = responseArr['tabcount6'];
      });
    }
  }



}
