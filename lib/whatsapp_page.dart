import 'dart:convert';
import 'package:crm_software/gloabal_variable.dart';
import 'package:crm_software/reminder_page.dart';
import 'package:crm_software/screen/menue_page.dart';
import 'package:crm_software/user_preference.dart';
import 'package:crm_software/whatsapp_chat.dart';
import 'package:crm_software/widgets/bottom_menue.dart';
import 'package:crm_software/widgets/header_first.dart';
import 'package:crm_software/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';
import 'modals/whatsapp_modal.dart';
import 'newlead_page.dart';

class WhatsappPage extends StatefulWidget {
  const WhatsappPage({Key? key}) : super(key: key);

  @override
  State<WhatsappPage> createState() => _WhatsappPageState();
}

class _WhatsappPageState extends State<WhatsappPage> {
  List<Whatsapplist> whatsapplist = [];
  List<Whatsapplist> _searchResult = [];
  int page = 1;
  bool loading = true;
  int _selectedIndex = 3;
  String? userToken = '';
  String? userId = '';
  TextEditingController controller = TextEditingController();

  // void onItemTaped(int index){
  //   setState(() {
  //     _selectedIndex = index;
  //     if(_selectedIndex == 0){
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(tabIndex: 0)));
  //     }else if(_selectedIndex == 1){
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ReminderPage()));
  //     }else if(_selectedIndex == 2){
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MenuePage()));
  //     }else if(_selectedIndex == 4){
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NewleadPage()));
  //     }
  //   });
  // }

  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    getData(userToken, userId, page);
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
          // child: topHeaderBar(),
        ),
      ),
      drawer: MyDrawer(),
      body: _buildBody(),
      bottomNavigationBar: BottomMenu(selectedIndex: 3),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Container(
          child: _buildSearchBox(),
        ),
        Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty ? _buildSearchResults() : _buildUsersList(),
        ),
      ],
    );
  }

  Widget _buildSearchBox() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(30),
      //   border: Border.all(
      //     color: Colors.blue,
      //     width: 1,
      //   ),
      // ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black, fontSize: 16.0,),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.green,),
          suffixIcon: controller.text.length > 0 ? IconButton(
            icon: Icon(Icons.cancel, color: Colors.red,),
            onPressed: () {
              controller.clear();
              onSearchTextChanged('');
            },
          ) : SizedBox(width: 0,),
          hintText: 'Search',
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        onChanged: onSearchTextChanged,
      ),
    );
  }

  Widget _buildUsersList() {
    return Container(
      child: whatsapplist.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: whatsapplist.length,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => WhatsappChat(leadId: whatsapplist[index].leadId, userName: whatsapplist[index].cname, leadStatus: whatsapplist[index].lQuality),
                  ),
                  );
                },
                contentPadding: EdgeInsets.zero,
                leading: Material(
                  borderRadius: BorderRadius.circular(50),
                  shadowColor: Colors.black,
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Text('${whatsapplist[index].cname![0].toUpperCase()}', style: TextStyle(shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                ),
                title: Text('${whatsapplist[index].cname}'),
                subtitle: Text('${whatsapplist[index].lQuality}'),
                trailing: Text('${whatsapplist[index].whdate}'),
              ),
            );
          }
      ),
    );
  }

  Widget _buildSearchResults() {
    return Container(
      child: _searchResult.isEmpty ? Center(child: Text('No results found', style: TextStyle(fontSize: 16),)) : ListView.builder(
          itemCount: _searchResult.length,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => WhatsappChat(leadId: whatsapplist[index].leadId, userName: whatsapplist[index].cname, leadStatus: whatsapplist[index].lQuality),
                  ),
                  );
                },
                contentPadding: EdgeInsets.zero,
                leading: Material(
                  borderRadius: BorderRadius.circular(50),
                  shadowColor: Colors.black,
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Text('${_searchResult[index].cname![0].toUpperCase()}', style: TextStyle(shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                ),
                title: Text('${_searchResult[index].cname}'),
                subtitle: Text('${_searchResult[index].lQuality}'),
                trailing: Text('${_searchResult[index].whdate}'),
              ),
            );
          }
      ),
    );
  }

  onSearchTextChanged(String searchVal) async {
    _searchResult.clear();
    if(searchVal.isEmpty){
      setState(() {});
      return;
    }
    whatsapplist.forEach((userDetail) {
      if(userDetail.cname!.toLowerCase().contains(searchVal.toLowerCase())){
        _searchResult.add(userDetail);
      }
      setState(() {});
    });
  }


  // void getData(userToken, userId, paraPage) async {
  //   var headersData = {
  //     "Content-type": "application/json",
  //     "Authorization": "Bearer $userToken"
  //   };
  //   var response = await http.get(
  //       Uri.parse(
  //           '$apiRootUrl/whatsapp_home.php?user_id=$userId&page_no=$page'),
  //       headers: headersData);
  //   WhatsappModal userClass = WhatsappModal.fromJson(json.decode(response.body));
  //   whatsapplist = whatsapplist + userClass.whatsapplist!;
  //   int localPage = page + 1;
  //   setState(() {
  //     whatsapplist;
  //     loading = false;
  //     page = localPage;
  //   });
  // }


  void getData(userToken, userId, paraPage) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/whatsapp_home.php';
    var url = Uri.parse(apiUrl);

    var data = {
      "user_id": userId,
      "page_no": page,
      "switch_user": filterUsers,
      "switch_source": filterSource,
      "switch_child": filterParentChild,
      "switch_leadtype": filterLeadType
    };
    var request = jsonEncode(data);
    var response = await http.post(
        url,
        body: request,
        headers: headersData
    );
    // var responsarr = jsonDecode(response.body);
    // print(responsarr);
    // return;
    WhatsappModal userClass = WhatsappModal.fromJson(json.decode(response.body));
    whatsapplist = whatsapplist + userClass.whatsapplist!;
    int localPage = page + 1;
    setState(() {
      whatsapplist;
      loading = false;
      page = localPage;
    });
  }



}
