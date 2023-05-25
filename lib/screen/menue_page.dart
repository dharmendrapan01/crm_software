import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../alldeleted_page.dart';
import '../closerpipeline_page.dart';
import '../data_enquiry_page.dart';
import '../freshenquiry_page.dart';
import '../gloabal_variable.dart';
import '../meeting_page.dart';
import '../miised_followup.dart';
import '../modals/menupage_modal.dart';
import '../newlead_page.dart';
import '../nqdelete_page.dart';
import '../old_enquiry_page.dart';
import '../qualified_delete_page.dart';
import '../qualified_page.dart';
import '../reminder_page.dart';
import '../sitevisit_page.dart';
import '../status_unknwn_page.dart';
import '../user_preference.dart';
import '../verge_closer_page.dart';
import '../whatsapp_page.dart';
import '../widgets/bottom_menue.dart';
import '../widgets/header_first.dart';
import '../widgets/header_section.dart';
import '../widgets/my_drawer.dart';
import 'allenquiry_lead.dart';
import 'dataenq_lead.dart';

class MenuePage extends StatefulWidget {
  const MenuePage({Key? key}) : super(key: key);

  @override
  State<MenuePage> createState() => _MenuePageState();
}

class _MenuePageState extends State<MenuePage> {
  String? userToken = '';
  String? userId = '';
  // List _items = [];
  List<Items> _items = [];

  @override
  void initState() {
    userToken = UserPreference.getUserToken() ?? '';
    userId = UserPreference.getUserId() ?? '';
    getMenueItem(userToken, userId);
    super.initState();
  }

  // int _selectedIndex = 2;
  // void onItemTaped(int index){
  //   setState(() {
  //     _selectedIndex = index;
  //     if(_selectedIndex == 0){
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ReminderPage(tabIndex: 0)));
  //     }else if(_selectedIndex == 1){
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ReminderPage(tabIndex: 0)));
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
        flexibleSpace: SafeArea(
          child: HeaderFirst(),
        ),
      ),
      drawer: MyDrawer(),
      body: Container(
        height: double.maxFinite,
        // height: MediaQuery.of(context).size.height * 0.50,
        child: ListView(
          // shrinkWrap: true,
          children: [
          HeaderSection(),
          bodySection(),
      ],
    ),
      ),
      bottomNavigationBar: BottomMenu(selectedIndex: 2,),
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

  Widget bodySection() {
    return _items.isEmpty ? Container(
        margin: EdgeInsets.only(top: 200),
        child: Center(child: CircularProgressIndicator())) : GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 4/4,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: InkWell(
              onTap: () {
                menuPageOpen(_items[index].menulink);
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: Color(int.parse('0x${_items[index].menucolor}')),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(IconData(int.parse('0x${_items[index].menuIcon}'), fontFamily: 'MaterialIcons'), color: Colors.white,),
                      SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.only(left: 2, right: 2),
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Center(child: Text(
                          '${_items[index].name}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 16),)),
                      ),
                      _items[index].menucount == '' ? SizedBox(height: 0,) : SizedBox(height: 5),
                      _items[index].menucount == '' ? SizedBox(height: 0,) : Text('(${_items[index].menucount})', style: TextStyle(color: Colors.white, fontSize: 16),),
                    ],
                  )
              ),
            ),
          );
        }
    );
  }

  // Widget bottomMenue(BuildContext context) {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
  //     child: BottomNavigationBar(
  //       type: BottomNavigationBarType.fixed,
  //       backgroundColor: Colors.black12,
  //       currentIndex: _selectedIndex,
  //       selectedItemColor: Colors.orange,
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


  // Future<void> getMenueItem() async {
  //   final String response = await rootBundle.loadString('assets/menuepage.json');
  //   // final data = await json.decode(response);
  //   // print(data);
  //   MenuPageModal projectListModal = MenuPageModal.fromJson(jsonDecode(response));
  //   _items = _items + projectListModal.items!;
  //   setState(() {
  //     _items = _items;
  //   });
  // }


  Future<void> getMenueItem(userToken, userId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/meupage.php?user_id=$userId'),
        headers: headersData);
    // print(response.body);
    MenuPageModal projectListModal = MenuPageModal.fromJson(jsonDecode(response.body));
    _items = _items + projectListModal.items!;
    setState(() {
      _items;
    });
  }

  void menuPageOpen(destination) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      switch(destination) {
        case 'all_enquiry':
          return AllenquiryLead();
          break;
        case 'fresh_enquiry':
          return FreshEnquiryPage();
          break;
        case 'data_enquiry':
          return DataEnquiryPage();
          break;
        case 'old_enquiry':
          return OldEnquiryPage();
          break;
        case 'qualified_page':
          return QualifiedPage();
          break;
        case 'status_unkn':
          return StatusUnknPage();
          break;
        case 'closer_pipeline':
          return CloserPipeLinePage();
          break;
        case 'verge_closer':
          return VergeCloserPage();
          break;
        case 'site_visit':
          return SiteVisitPage();
          break;
        case 'qualified_delete':
          return QualifiedDeletePage();
          break;
        case 'notqualify_delete':
          return NotQualDeletePage();
          break;
        case 'deleted_enquiry':
          return AllDeletedPage();
          break;
        case 'spam_delete':
          return AllDeletedPage(tabIndex: 3,);
          break;
        case 'meeting_page':
          return MeetingPage();
          break;
        case 'missed_followup':
          return MissedFollowup();
          break;
        case 'whatsapp_page':
          return WhatsappPage();
          break;
        default:
          return WhatsappPage();
      }
    }));
  }

}
