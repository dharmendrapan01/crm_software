import 'package:crm_software/reminder_page.dart';
import 'package:crm_software/search_body.dart';
import 'package:crm_software/whatsapp_page.dart';
import 'package:crm_software/widgets/header_section.dart';
import 'package:crm_software/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_page.dart';

class SearchPage extends StatefulWidget {
  String searchValue;
  String searchBox;
  SearchPage({Key? key, required this.searchBox, required this.searchValue}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  int _selectedIndex = -1;
  void onItemTaped(int index){
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 0){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(tabIndex: 0)));
      }else if(_selectedIndex == 1){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ReminderPage(tabIndex: 0)));
      }else if(_selectedIndex == 2){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(tabIndex: 0)));
      }else if(_selectedIndex == 3){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WhatsappPage()));
      }else if(_selectedIndex == 4){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(tabIndex: 0)));
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
        flexibleSpace: SafeArea(
          child: topHeaderBar(),
        ),
      ),
      drawer: MyDrawer(),
      body: Container(
        height: double.maxFinite,
        // margin: EdgeInsets.only(top: 30.0),
        child: ListView(
          children: [
            // TopHeader(),
            HeaderSection(),
            searchBodySec(widget.searchBox, widget.searchValue),
          ],
        ),
      ),
      bottomNavigationBar: bottomMenue(context),
    );
  }


  Container searchBodySec(searchBox, searchValue) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.81,
      child: Column(
        children: [
          Expanded(
            child: SearchBody(searchBox: searchBox, searchValue: searchValue),
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
        currentIndex: _selectedIndex == -1 ? 0 : _selectedIndex,
        selectedItemColor: _selectedIndex == -1 ? Colors.grey : Colors.orange,
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



