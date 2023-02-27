import 'package:crm_software/qualified_list.dart';
import 'package:crm_software/reminder_page.dart';
import 'package:crm_software/screen/menue_page.dart';
import 'package:crm_software/sms_call.dart';
import 'package:crm_software/user_preference.dart';
import 'package:crm_software/webmissed_call.dart';
import 'package:crm_software/website_rec_call.dart';
import 'package:crm_software/whatsapp_page.dart';
import 'package:crm_software/widgets/header_section.dart';
import 'package:crm_software/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'call_history.dart';
import 'favorite_list.dart';
import 'newlead_page.dart';


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

  int _selectedIndex = 0;
  void onItemTaped(int index){
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 1){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ReminderPage(tabIndex: 0)));
      }else if(_selectedIndex == 2){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MenuePage()));
      }else if(_selectedIndex == 3){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WhatsappPage()));
      }else if(_selectedIndex == 4){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NewleadPage()));
      }
    });
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
          child: topHeaderBar(),
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

      bottomNavigationBar: bottomMenue(context),
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


  Container topHeaderBar() {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 40,),
          Image.asset('assets/images/salesapp.png', width: 100),
          Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: ElevatedButton(
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
          ),
        ],
      ),
    );
  }


  Widget bottomMenue(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black12,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.call, color: Colors.green,),
              label: 'Calls',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active_rounded, color: Colors.red,),
              label: 'Reminder',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green,),
              label: 'Whatsapp',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_alt, color: Colors.red,),
              label: 'New Lead',
          ),
        ],
        onTap: onItemTaped,
      ),
    );
  }


}

