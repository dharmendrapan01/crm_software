import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:http/http.dart' as http;
import '../gloabal_variable.dart';
import '../home_page.dart';
import '../modals/sourcelist_modal.dart';
import '../modals/user_modal.dart';
import '../user_preference.dart';

class FilterWidgetPage extends StatefulWidget {
  const FilterWidgetPage({Key? key}) : super(key: key);

  @override
  State<FilterWidgetPage> createState() => _FilterWidgetPageState();
}

class _FilterWidgetPageState extends State<FilterWidgetPage> {
  List<Userlist> users = [];
  List<Sourcelist> sources = [];
  String? userToken = '';
  String? userId = '';
  String parentChild = '';
  String leadType = '';
  List<dynamic> _selectedUsers = [];
  List<dynamic> _selectedSource = [];

  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    getUserList(userToken);
    getSourceList(userToken);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Choose your filter', style: TextStyle(fontSize: 18, color: Colors.blue),),
            SizedBox(height: 10,),
            SingleChildScrollView(
              child: MultiSelectBottomSheetField(
                selectedColor: Colors.orange,
                listType: MultiSelectListType.LIST,
                chipDisplay: MultiSelectChipDisplay.none(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                buttonIcon: Icon(
                  Icons.account_box,
                  color: Colors.orange,
                ),
                buttonText: Text(
                  "Switch User",
                  style: TextStyle(color: Colors.black, fontSize: 16.0,),
                ),
                title: Text('Select User', style: TextStyle(color: Colors.black, fontSize: 16.0,)),
                searchable: true,
                items: users.map((user) => MultiSelectItem<Userlist?>(user, user.userName!)).toList(),
                onConfirm: (results) async {
                  _selectedUsers = results;
                },
              ),
            ),
            SizedBox(height: 10,),
            InputDecorator(
              decoration: InputDecoration(
                labelText: 'Lead Type',
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: leadType,
                  isDense: true,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(child: Text("Switch Type"), value: ""),
                    DropdownMenuItem(child: Text("Fresh Enquiry"), value: "fresh"),
                    DropdownMenuItem(child: Text("Data Enquiry"), value: "data_lead"),
                    DropdownMenuItem(child: Text("Old Enquiry"), value: "old_lead"),
                  ],
                  onChanged: (newLeadType) => {
                    setState(() {
                      leadType = newLeadType!;
                    }),
                  },
                ),
              ),
            ),
            SizedBox(height: 10,),
            InputDecorator(
              decoration: InputDecoration(
                labelText: 'Parent/Child',
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: parentChild,
                  isDense: true,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(child: Text("View All"), value: ""),
                    DropdownMenuItem(child: Text("Parent Lead"), value: "1"),
                    DropdownMenuItem(child: Text("Child Lead"), value: "2"),
                  ],
                  onChanged: (newParentChild) => {
                    setState(() {
                      parentChild = newParentChild!;
                    }),
                  },
                ),
              ),
            ),
            SizedBox(height: 10,),
            SingleChildScrollView(
              child: MultiSelectBottomSheetField(
                selectedColor: Colors.orange,
                listType: MultiSelectListType.LIST,
                chipDisplay: MultiSelectChipDisplay.none(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                buttonIcon: Icon(
                  Icons.source,
                  color: Colors.orange,
                ),
                buttonText: Text(
                  "Switch Source",
                  style: TextStyle(color: Colors.black, fontSize: 16.0,),
                ),
                title: Text('Select Source', style: TextStyle(color: Colors.black, fontSize: 16.0,)),
                searchable: true,
                items: sources.map((source) => MultiSelectItem<Sourcelist?>(source, source.sourceName!)).toList(),
                onConfirm: (results) {
                  _selectedSource = results;
                },
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    switchFilter();
                  },
                  child: Text('Switch', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    clearSwitchFilter();
                  },
                  child: Text('Clear', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getUserList(userToken) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/user-list.php'),
        headers: headersData);
    // var responseArr = jsonDecode(response.body);
    // print(responseArr);return;
    UserModalClass userModalClass = UserModalClass.fromJson(jsonDecode(response.body));
    users = users + userModalClass.userlist!;
    setState(() {
      users;
    });
  }

  void getSourceList(userToken) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/source_list.php'),
        headers: headersData);
    SourceListModal sourceListModal = SourceListModal.fromJson(jsonDecode(response.body));
    sources = sources + sourceListModal.sourcelist!;
    setState(() {
      sources;
    });
  }

  Future<void> switchFilter() async {
    filterUsers = _selectedUsers;
    filterSource = _selectedSource;
    filterParentChild = parentChild;
    filterLeadType = leadType;
    Fluttertoast.showToast(
        msg: 'Switch Filter Successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20.0
    );
    Navigator.pop(context);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(tabIndex: 0)));
  }

  void clearSwitchFilter() {
    filterUsers = [];
    filterSource = [];
    filterParentChild = '';
    filterLeadType = '';
    Fluttertoast.showToast(
        msg: 'Clear Filter Successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20.0
    );
    Navigator.pop(context);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(tabIndex: 0)));
  }


}
