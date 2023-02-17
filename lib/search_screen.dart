import 'package:crm_software/search_body.dart';
import 'package:crm_software/widgets/header_section.dart';
import 'package:crm_software/widgets/my_drawer.dart';
import 'package:crm_software/widgets/top_header.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  String searchValue;
  String searchBox;
  SearchPage({Key? key, required this.searchBox, required this.searchValue}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
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
    int _selectedIndex = 0;
    TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    List<Widget> _widgetOptions = <Widget>[
      Text(
        'Index 0: Home',
        style: optionStyle,
      ),
      Text(
        'Index 1: Business',
        style: optionStyle,
      ),
      Text(
        'Index 2: School',
        style: optionStyle,
      ),
      Text(
        'Index 3: Setting',
        style: optionStyle,
      ),
    ];

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black,),
          label: 'Home',
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black,),
          label: 'Business',
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black,),
          label: 'School',
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black,),
          label: 'Setting',
          backgroundColor: Colors.grey,
        ),
      ],
    );
  }



}



