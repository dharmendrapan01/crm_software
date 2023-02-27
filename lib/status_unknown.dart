import 'dart:convert';

import 'package:crm_software/gloabal_variable.dart';
import 'package:crm_software/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'modals/leadupdate_modal.dart';

class StatusUnknown extends StatefulWidget {
  final leadId;
  const StatusUnknown({Key? key, this.leadId}) : super(key: key);

  @override
  State<StatusUnknown> createState() => _StatusUnknownState();
}

class _StatusUnknownState extends State<StatusUnknown> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController leadIdText = TextEditingController();
  TextEditingController custNameText = TextEditingController();
  TextEditingController comment = TextEditingController();
  String leadQuality = '2';
  String leadSubQuality = '2';
  bool _isButtonDisabled = false;
  List<Leadupdatepop> updateleaddata = [];
  String? userToken = '';
  String? userId = '';

  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    leadIdText.text = widget.leadId;
    getleadUpdate(userToken, widget.leadId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: _scaffoldkey,
        body: Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: ListView(
              children: [
                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: leadIdText,
                        style: TextStyle(color: Colors.black, fontSize: 16.0,),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          labelText: 'Lead Id',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10,),

                    Expanded(
                      child: TextFormField(
                        controller: custNameText,
                        style: TextStyle(color: Colors.black, fontSize: 16.0,),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Quality',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: leadQuality,
                            isDense: true,
                            isExpanded: true,
                            items: [
                              DropdownMenuItem(child: Text("Status Unknown"), value: "2"),
                            ],
                            onChanged: (newValue) => {
                              setState(() {
                                leadQuality = newValue!;
                                // print(quality.toString());
                              }),
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10,),

                    Expanded(
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Reason For Status Unknown',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: leadSubQuality,
                            isDense: true,
                            isExpanded: true,
                            items: [
                              DropdownMenuItem(child: Text("Not Picked"), value: "2"),
                              DropdownMenuItem(child: Text("Busy"), value: "1"),
                              DropdownMenuItem(child: Text("Call Later"), value: "3"),
                              DropdownMenuItem(child: Text("Call Picked By Other"), value: "4"),
                              DropdownMenuItem(child: Text("Disconnecting The Call"), value: "5"),
                              DropdownMenuItem(child: Text("Not Reachable"), value: "6"),
                              DropdownMenuItem(child: Text("Temporary Out Of Service"), value: "7"),
                              DropdownMenuItem(child: Text("Switched Off"), value: "8"),
                              DropdownMenuItem(child: Text("Diverting Other Number"), value: "9"),
                              DropdownMenuItem(child: Text("Call Not Connecting"), value: "10"),
                            ],
                            onChanged: (newValue) => {
                              setState(() {
                                leadSubQuality = newValue!;
                                // print(quality.toString());
                              }),
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: comment,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 5,
                          style: TextStyle(color: Colors.black, fontSize: 16.0,),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            labelText: 'Comment',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please Enter Comment';
                            }else{
                              return null;
                            }
                          }
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          _isButtonDisabled ? null : updateStatusUnkn(userToken, userId, widget.leadId);
                        }
                      },
                      child: Text('SUBMIT', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getleadUpdate(userToken, leadId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/lead_update.php?lead_id=$leadId'),
        headers: headersData);
    UpdateLead leadUpdateData = UpdateLead.fromJson(jsonDecode(response.body));
    updateleaddata = updateleaddata + leadUpdateData.leadupdatepop!;
    if(updateleaddata.isNotEmpty){
      setState(() {
        custNameText.text = updateleaddata[0].custName!;
        if(updateleaddata[0].comment == 'NA'){comment.text = '';}else{comment.text = updateleaddata[0].comment!;}
      });

    }
  }


  Future<void> updateStatusUnkn(userToken, userId, leadId) async {
    setState(() {
      _isButtonDisabled = true;
    });
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/statusunkwn_lead.php';
    var url = Uri.parse(apiUrl);

    var data = {
      "lead_id": leadId,
      "user_id": userId,
      "cust_name": custNameText.text,
      "lead_quality": leadQuality,
      "lead_subquality": leadSubQuality,
      "meet_comment": comment.text,
    };

    // print(data);
    var request = jsonEncode(data);

    Response response =
    await http.post(url, body: request, headers: headersData);

    if (response.statusCode == 200) {
      var responseArr = jsonDecode(response.body);
      // print(responseArr); return;
      if (responseArr['rstatus'] == '1') {
        Fluttertoast.showToast(
            msg: 'Lead Status Unknown Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: 'Something Went Wrong!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Incorrect api url',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20.0);
    }

    setState(() {
      _isButtonDisabled = false;
    });
  }

}
