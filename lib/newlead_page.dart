import 'dart:convert';

import 'package:crm_software/screen/microsite_lead.dart';
import 'package:crm_software/screen/smsinbound_lead.dart';
import 'package:crm_software/screen/websitecall_lead.dart';
import 'package:crm_software/screen/whatsapp_lead.dart';
import 'package:crm_software/user_preference.dart';
import 'package:crm_software/widgets/bottom_menue.dart';
import 'package:crm_software/widgets/header_first.dart';
import 'package:crm_software/widgets/header_section.dart';
import 'package:crm_software/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'gloabal_variable.dart';

class NewleadPage extends StatefulWidget {
  final tabIndex;
  final tabDate;
  const NewleadPage({Key? key, this.tabIndex, this.tabDate}) : super(key: key);

  @override
  State<NewleadPage> createState() => _NewleadPageState();
}

class _NewleadPageState extends State<NewleadPage> with TickerProviderStateMixin {
  String? userToken = '';
  String? userId = '';
  TextEditingController searchdate = TextEditingController();
  String curreDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String micrositecount = '0';
  String smsinboundcount = '0';
  String websitecallcount = '0';
  String whatsappcount = '0';


  @override
  void initState() {
    widget.tabDate != null ? searchdate.text = widget.tabDate : searchdate.text = curreDate;
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    getCountVal(userToken, userId, searchdate.text);
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
      bottomNavigationBar: BottomMenu(selectedIndex: 4,),
    );
  }


  Container bodySection(tabIndex) {
    TabController _tabController = TabController(
        length: 4, initialIndex: tabIndex == null ? tabIndex = 0 : tabIndex = tabIndex, vsync: this
    );
    return Container(
      height: MediaQuery.of(context).size.height * 0.81,
      child: Column(
        children: [
          SizedBox(height: 5,),

          Container(
            height: 40,
            child: TextField(
              readOnly: true,
              controller: searchdate,
              style: TextStyle(color: Colors.black, fontSize: 16.0,),
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.calendar_today, color: Colors.orange,),
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                hintText: 'Search by date',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),

              onTap: () async {
                DateTime? pickedDate =  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100)
                );
                if(pickedDate != null){
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  searchdate.text = formattedDate;
                  setState(() {
                    getCountVal(userToken, userId, searchdate.text);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NewleadPage(tabDate: searchdate.text)));
                  });
                }
              },
            ),
          ),

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
                  Tab(child: Text('Microsite ${micrositecount}', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('SMS Inbound ${smsinboundcount}', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('Website Call ${websitecallcount}', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('Whatsapp ${whatsappcount}', style: TextStyle(color: Colors.black),),),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                MicrositeLead(searchDate: searchdate.text),
                SmsinboundLead(searchDate: searchdate.text),
                WebsiteCallLead(searchDate: searchdate.text),
                WhatsappLead(searchDate: searchdate.text),
              ],
            ),
          ),
        ],
      ),
    );
  }



  // void getCountVal(userToken, userId, searchDate) async {
  //   var headersData = {
  //     "Content-type": "application/json",
  //     "Authorization": "Bearer $userToken"
  //   };
  //   var response = await http.get(
  //       Uri.parse(
  //           '$apiRootUrl/newleadcount.php?user_id=$userId&search_date=$searchDate'),
  //       headers: headersData);
  //   var responseArr = jsonDecode(response.body);
  //   setState(() {
  //     micrositecount = responseArr['micrositecount'];
  //     smsinboundcount = responseArr['smsinboundcount'];
  //     websitecallcount = responseArr['websitecallcount'];
  //     whatsappcount = responseArr['whatsappcount'];
  //   });
  // }


  Future getCountVal(userToken, userId, searchDate) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/newleadcount.php';
    var url = Uri.parse(apiUrl);

    var data = {
      "user_id": userId,
      "search_date": searchDate,
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
        micrositecount = responseArr['micrositecount'];
        smsinboundcount = responseArr['smsinboundcount'];
        websitecallcount = responseArr['websitecallcount'];
        whatsappcount = responseArr['whatsappcount'];
      });
    }
  }

}
