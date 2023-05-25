import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../home_page.dart';
import '../newlead_page.dart';
import '../reminder_page.dart';
import '../screen/menue_page.dart';
import '../whatsapp_page.dart';

class BottomMenu extends StatefulWidget {
  final selectedIndex;
  const BottomMenu({Key? key, this.selectedIndex}) : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _selectedIndex = 0;
  void onItemTaped(int index){
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 0){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(tabIndex: 0)));
      }else if(_selectedIndex == 1){
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
  void initState() {
    if(widget.selectedIndex == null){
      _selectedIndex = -1;
    }else{
      _selectedIndex = widget.selectedIndex;
    }
    // print(_selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.new_releases, color: Colors.red,),
            label: 'New Lead',
          ),
        ],
        onTap: onItemTaped,
      ),
    );
  }
}
