import 'package:crm_software/login_page.dart';
import 'package:crm_software/qualified_list.dart';
import 'package:crm_software/sms_call.dart';
import 'package:crm_software/user_preference.dart';
import 'package:crm_software/webmissed_call.dart';
import 'package:crm_software/website_rec_call.dart';
import 'package:crm_software/widgets/header_section.dart';
import 'package:crm_software/widgets/top_header.dart';
import 'package:flutter/material.dart';
import 'call_history.dart';
import 'favorite_list.dart';


class HomePage extends StatefulWidget {
  int tabIndex;
  HomePage({Key? key, required this.tabIndex}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String userToken = '';
  @override
  void initState(){
    super.initState();
    userToken = UserPreference.getUserToken() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userToken == '' ? LoginPage() : ListView(
        children: [
          // topHeader(),
          TopHeader(),
          HeaderSection(),
          // headerSection(),
          bodySection(widget.tabIndex),
        ],
      ),
    );
  }


  Container bodySection(tabIndex) {
    TabController _tabController = TabController(
        length: 6, initialIndex: tabIndex == null ? tabIndex = 0 : tabIndex = tabIndex, vsync: this
    );
    return Container(
      height: double.maxFinite,
      child: Column(
        children: [
          // SizedBox(height: 5,),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
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
                  Tab(child: Text('ALL', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('FAVORITE', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('QUALIFIED', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('WEB. RECEIVED', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('WEB. MISSED', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('SMS CALL', style: TextStyle(color: Colors.black),),),
                ],
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AllCallHistory(),
                FavoriteList(),
                QualifiedList(),
                WebsiteRecCall(),
                WebMissedCall(),
                SmsCall(),
              ],
            ),
          ),
        ],
      ),
    );
  }


}

