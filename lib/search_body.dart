import 'dart:convert';

import 'package:crm_software/gloabal_variable.dart';
import 'package:crm_software/search_screen.dart';
import 'package:crm_software/user_preference.dart';
import 'package:crm_software/widgets/lead_update.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:crm_software/modals/cli_number.dart';
import 'lead_view.dart';
import 'modals/search_modal.dart';

class SearchBody extends StatefulWidget {
  String searchValue;
  String searchBox;
  SearchBody({Key? key, required this.searchBox, required this.searchValue}) : super(key: key);

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  List<Datalist> result = [];
  List<Clilist> clinumber = [];
  String? userToken = '';
  String? userId = '';

  @override
  void initState() {
    super.initState();
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    getSearchData(userToken, userId, widget.searchValue, widget.searchBox);
    // getCLI(userId, userToken);
    setState(() {
      getCLI(userId, userToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
          child: result.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
            padding: EdgeInsets.all(0.0),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: result.length,
            itemBuilder: (context, index) {
              if(result[index].leadId!.isNotEmpty){
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            enableDrag: false,
                            isDismissible: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            context: context,
                            builder: (context) => cliSheet(result[index].mobileno, result[index].leadId, result[index].agentmobile),
                          );
                          // clickToCall(result[index].mobileno, result[index].agentmobile, result[index].leadId, result[index].callerid);
                        },
                        child: ListTile(
                          // leading: Icon(Icons.call_received, color: Colors.green),
                          title: Text('${result[index].custName}  (${result[index].leadId})',
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text('${result[index].mdate}  ${result[index].project}', maxLines: 1,
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                              SizedBox(height: 5,),
                              Text('${result[index].nomasked}', style: TextStyle(color: Colors.black),),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${result[index].agent}  ${result[index].leadQuality}',
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.more_vert, color: Colors.black,),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) => LeadView(leadId: result[index].leadId),
                              ),
                              );
                            },
                            child: Image.asset('assets/images/view.png', width: 40, height: 40,),
                          ),
                          InkWell(
                            onTap: (){
                              showModalBottomSheet(
                                enableDrag: false,
                                isDismissible: false,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                ),
                                context: context,
                                builder: (context) => LeadUpdate(leadId: result[index].leadId),
                              );
                            },
                            child: Image.asset('assets/images/plus.png', width: 35, height: 35,),
                          ),
                          InkWell(
                            onTap: () {
                              addFavorite(result[index].leadId, userToken);
                            },
                            child: result[index].favorite == '1' ? Image.asset('assets/images/impclient-active.png', width: 40,height: 40) : Image.asset('assets/images/impclient.png', width: 40,height: 40),
                          ),
                          Image.asset(
                            'assets/images/lead-view.png',
                            width: 40,
                            height: 40,
                          ),
                          Image.asset(
                            'assets/images/messages.png',
                            width: 40,
                            height: 40,
                          ),
                          Image.asset(
                            'assets/images/whatsapp.png',
                            width: 40,
                            height: 40,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              }else{
                return Container(
                  height: 100,
                    child: SizedBox(
                      height: 20,
                      child: Center(
                        child: Text(
                        'Data Not Available', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.red),
                      ),
                      ),
                    ),
                );
              }
            },
          ),
        ),
      );
    // );
  }

  Future getSearchData(userToken, userId, searchValue, searchBox) async {
    // print(loading);
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/search-lead.php?user_id=$userId&lead_id=$searchValue&search_box=$searchBox'),
        headers: headersData);
    Search userClass = Search.fromJson(json.decode(response.body));
    result = result + userClass.datalist!;
      setState(() {
        result;
      });
  }


  void addFavorite(leadId, userToken) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var reqParameter = {
      "lead_id": "$leadId"
    };
    var response = await http.post(Uri.parse('$apiRootUrl/add_favorite.php'), headers: headersData, body: jsonEncode(reqParameter));
    if(response.statusCode == 200){
      Fluttertoast.showToast(
          msg: 'Data updated Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20.0
      );
    }
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => SearchPage(searchBox: widget.searchBox, searchValue: widget.searchValue)), (Route<dynamic> route) => false);
  }


  Widget cliSheet(destMobile, leadId, agentMobile) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height: 15,),
      Text('Choose one of the below', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
      SizedBox(height: 15,),
      Container(
        width: 230,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: clinumber.length,
          itemBuilder: (context, index) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                minimumSize: Size(250, 40),
              ),
              onPressed: () {
                clickToCall(destMobile, agentMobile, leadId, clinumber[index].clinumber);
                Navigator.pop(context);
              },
              child: Text('${clinumber[index].clinumber}', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
            );
          },
        ),
      ),

      SizedBox(height: 20.0,),

      ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: Text('Close', style: TextStyle(color: Colors.white, fontSize: 20.0),),
      ),
      SizedBox(height: 20.0,),
    ],
  );


  void getCLI(userId, userToken) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(Uri.parse('$apiRootUrl/cli_number.php?user_id=$userId'), headers: headersData);
    // print(response);
    CliModal cliModalClass = CliModal.fromJson(json.decode(response.body));
    clinumber = clinumber + cliModalClass.clilist!;
    // int localPage = page + 1;
    setState(() {
      clinumber;
    });
  }


  void clickToCall(custNumber, agentMobile, leadId, callerId) async {
    // print(callerId);
    Fluttertoast.showToast(
        msg: 'Connecting...',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20.0
    );

    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    custNumber = stringToBase64.decode(custNumber);
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjE2NTY4NCwiaXNzIjoiaHR0cHM6XC9cL2Nsb3VkcGhvbmUudGF0YXRlbGVzZXJ2aWNlcy5jb21cL3Rva2VuXC9nZW5lcmF0ZSIsImlhdCI6MTYzNzY3NjQwNiwiZXhwIjoxOTM3Njc2NDA2LCJuYmYiOjE2Mzc2NzY0MDYsImp0aSI6InBQbjBtY2tIQmV2OXZQYjYifQ.tTTg5sSeUyE2dGDLRnAUJDGb4pIKBPpDJGWRy7s7UVY",
    };
    var reqParameter = {
      "destination_number": "$custNumber",
      "agent_number": "$agentMobile",
      "caller_id": "$callerId",
      "custom_identifier": "$leadId"
    };
    // print(reqParameter);

    var response = await http.post(Uri.parse('https://api-smartflo.tatateleservices.com/v1/click_to_call'), headers: headersData, body: jsonEncode(reqParameter));
    // print(response.body);
  }

}