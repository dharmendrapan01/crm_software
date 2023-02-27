import 'dart:convert';

import 'package:crm_software/gloabal_variable.dart';
import 'package:crm_software/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'modals/leadupdate_modal.dart';

class DeleteLead extends StatefulWidget {
  final leadId;
  const DeleteLead({Key? key, this.leadId}) : super(key: key);

  @override
  State<DeleteLead> createState() => _DeleteLeadState();
}

class _DeleteLeadState extends State<DeleteLead> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController leadIdText = TextEditingController();
  TextEditingController custNameText = TextEditingController();
  TextEditingController comment = TextEditingController();
  String leadQuality = '4';
  String spamType = '4';
  String notQualType = '2';
  String notInterestType = '1';
  String budgetType = '';
  List<Leadupdatepop> updateleaddata = [];
  String? userToken = '';
  String? userId = '';
  bool _isButtonDisabled = false;
  bool isSpamTypeVisible = true;
  bool isSubTypeVisible = true;
  bool isNotIntVisible = false;
  bool isSubSubTypeVisible = false;

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
            child: updateleaddata.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      SizedBox(height: 15,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              controller: leadIdText,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8.0),
                                labelText: 'Lead Id',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: custNameText,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8.0),
                                labelText: 'Name',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
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
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8.0),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: leadQuality,
                                  isDense: true,
                                  isExpanded: true,
                                  items: [
                                    DropdownMenuItem(
                                        child: Text("Spam Delete"), value: "4"),
                                    DropdownMenuItem(
                                        child: Text("NQ Delete"), value: "3"),
                                    DropdownMenuItem(
                                        child: Text("Broker Delete"), value: "5"),
                                    DropdownMenuItem(
                                        child: Text("Builder Delete"), value: "6"),
                                    DropdownMenuItem(
                                        child: Text("Duplicate Delete"),
                                        value: "7"),
                                  ],
                                  onChanged: (newValue) => {
                                    setState(() {
                                      leadQuality = newValue!;
                                      if (newValue == '3') {
                                        isSpamTypeVisible = false;
                                        isSubTypeVisible = true;
                                      } else if (newValue == '4') {
                                        isSpamTypeVisible = true;
                                        isSubTypeVisible = true;
                                      } else {
                                        isSubTypeVisible = false;
                                        isSubSubTypeVisible = false;
                                      }
                                    }),
                                  },
                                ),
                              ),
                            ),
                          ),

                          // SizedBox(width: 10,),

                          Visibility(
                            visible: isSubTypeVisible ? true : false,
                            child: Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: Visibility(
                                  visible: isSpamTypeVisible ? true : false,
                                  replacement: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'NQ Type',
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: notQualType,
                                        isDense: true,
                                        isExpanded: true,
                                        items: [
                                          DropdownMenuItem(
                                              child: Text("Not Interested"),
                                              value: "2"),
                                          DropdownMenuItem(
                                              child: Text("Resale"), value: "12"),
                                          DropdownMenuItem(
                                              child: Text("Low Budget"), value: "3"),
                                          DropdownMenuItem(
                                              child: Text("Already Purchased"),
                                              value: "11"),
                                          DropdownMenuItem(
                                              child: Text("Seller"), value: "5"),
                                          DropdownMenuItem(
                                              child: Text("Lessor"), value: "6"),
                                          DropdownMenuItem(
                                              child: Text("Lessee"), value: "7"),
                                          DropdownMenuItem(
                                              child: Text("Other"), value: "10"),
                                        ],
                                        onChanged: (newValue) => {
                                          setState(() {
                                            notQualType = newValue!;
                                            if (newValue == '2') {
                                              isNotIntVisible = true;
                                              isSubSubTypeVisible = true;
                                            }else if(newValue == '3'){
                                              isNotIntVisible = false;
                                              isSubSubTypeVisible = true;
                                            } else {
                                              isSubSubTypeVisible = false;
                                            }
                                          }),
                                        },
                                      ),
                                    ),
                                  ),
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Spam Type',
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: spamType,
                                        isDense: true,
                                        isExpanded: true,
                                        items: [
                                          DropdownMenuItem(
                                              child: Text("Not Eligible"),
                                              value: "4"),
                                          DropdownMenuItem(
                                              child: Text("DND Spam"), value: "5"),
                                          DropdownMenuItem(
                                              child: Text("Wrong Number"),
                                              value: "10"),
                                          DropdownMenuItem(
                                              child: Text("Telecom Spam"),
                                              value: "1"),
                                          DropdownMenuItem(
                                              child: Text("Marketing Spam"),
                                              value: "2"),
                                          DropdownMenuItem(
                                              child: Text("Robotics Spam"),
                                              value: "3"),
                                          DropdownMenuItem(
                                              child: Text("Language Spam"),
                                              value: "6"),
                                          DropdownMenuItem(
                                              child: Text("Test Spam"), value: "7"),
                                          DropdownMenuItem(
                                              child: Text("SMS Server Spam"),
                                              value: "8"),
                                          DropdownMenuItem(
                                              child: Text("Uncontactable Spam"),
                                              value: "9"),
                                          DropdownMenuItem(
                                              child: Text("Job Spam"), value: "11"),
                                          DropdownMenuItem(
                                              child: Text("Marketing Vendor"),
                                              value: "12"),
                                        ],
                                        onChanged: (newValue) => {
                                          setState(() {
                                            spamType = newValue!;
                                            // print(quality.toString());
                                          }),
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Visibility(
                        visible: isSubSubTypeVisible ? true : false,
                        child: Container(
                          margin: EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: isNotIntVisible ? true : false,
                                replacement: Expanded(
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Budget Type',
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: budgetType,
                                        isDense: true,
                                        isExpanded: true,
                                        items: [
                                          DropdownMenuItem(
                                              child:
                                              Text("Select Budget"),
                                              value: ""),
                                          DropdownMenuItem(
                                              child: Text("10 Lakh - 20 Lakh"),
                                              value: "1"),
                                          DropdownMenuItem(
                                              child: Text("20 Lakh - 30 Lakh"),
                                              value: "2"),
                                          DropdownMenuItem(
                                              child: Text("30 Lakh - 40 Lakh"),
                                              value: "3"),
                                          DropdownMenuItem(
                                              child: Text("40 Lakh - 60 Lakh"),
                                              value: "4"),
                                          DropdownMenuItem(
                                              child: Text("60 Lakh - 80 Lakh"),
                                              value: "5"),
                                          DropdownMenuItem(
                                              child: Text("80 Lakh - 1 Cr."),
                                              value: "6"),
                                          DropdownMenuItem(
                                              child: Text(
                                                  "1 Cr. - 1.25 Cr."),
                                              value: "7"),
                                          DropdownMenuItem(
                                              child: Text("1.25 Cr. - 1.50 Cr."),
                                              value: "8"),
                                        ],
                                        onChanged: (newValue) => {
                                          setState(() {
                                            budgetType = newValue!;
                                          }),
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                child: Expanded(
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Not Interested Type',
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: notInterestType,
                                        isDense: true,
                                        isExpanded: true,
                                        items: [
                                          DropdownMenuItem(
                                              child:
                                                  Text("Not Searching Any Property"),
                                              value: "1"),
                                          DropdownMenuItem(
                                              child: Text("Already Purchased"),
                                              value: "2"),
                                          DropdownMenuItem(
                                              child: Text("Location Mismatch"),
                                              value: "3"),
                                          DropdownMenuItem(
                                              child: Text("Directly Said No"),
                                              value: "4"),
                                          DropdownMenuItem(
                                              child: Text("Never Call Again"),
                                              value: "5"),
                                          DropdownMenuItem(
                                              child: Text("Drop The Idea"),
                                              value: "6"),
                                          DropdownMenuItem(
                                              child: Text(
                                                  "Client Will Call When Required"),
                                              value: "7"),
                                          DropdownMenuItem(
                                              child: Text("Call Disconnected"),
                                              value: "8"),
                                        ],
                                        onChanged: (newValue) => {
                                          setState(() {
                                            notInterestType = newValue!;
                                          }),
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8.0),
                                  labelText: 'Comment',
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Comment';
                                  } else {
                                    return null;
                                  }
                                }),
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
                                _isButtonDisabled ? null : deleteLead(userToken, userId, widget.leadId);
                              }
                            },
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
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
    if (updateleaddata.isNotEmpty) {
      setState(() {
        custNameText.text = updateleaddata[0].custName!;
        if(updateleaddata[0].comment == 'NA'){comment.text = '';}else{comment.text = updateleaddata[0].comment!;}
      });
    }
  }


  Future<void> deleteLead(userToken, userId, leadId) async {
    setState(() {
      _isButtonDisabled = true;
    });
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/delete_lead.php';
    var url = Uri.parse(apiUrl);

    var data = {
      "lead_id": leadId,
      "user_id": userId,
      "cust_name": custNameText.text,
      "del_quality": leadQuality,
      "notqual_type": notQualType,
      "spam_type": spamType,
      "notint_type": notInterestType,
      "budget_type": budgetType,
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
            msg: 'Lead Deleted Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0);
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
