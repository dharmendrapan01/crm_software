import 'dart:convert';

import 'package:crm_software/gloabal_variable.dart';
import 'package:crm_software/user_preference.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'modals/leadupdate_modal.dart';

class VoiceCallDone extends StatefulWidget {
  final leadId;
  const VoiceCallDone({Key? key, this.leadId}) : super(key: key);

  @override
  State<VoiceCallDone> createState() => _VoiceCallDoneState();
}

class _VoiceCallDoneState extends State<VoiceCallDone> {
  TextEditingController leadIdText = TextEditingController();
  TextEditingController custNameText = TextEditingController();
  TextEditingController meetdatetime = TextEditingController();
  TextEditingController comment = TextEditingController();
  String metStatus = 'held';
  String mainDisposition = 'contacted';
  String subDisposition = '';
  List<Leadupdatepop> updateleaddata = [];
  String? userToken = '';
  String? userId = '';
  String curreMeetDateTime = DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());
  bool _isButtonDisabled = false;

  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    leadIdText.text = widget.leadId;
    meetdatetime.text = curreMeetDateTime;
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
        body: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: updateleaddata.isEmpty ? Center(child: CircularProgressIndicator()) : ListView(
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
                        labelText: 'VC Status',
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: metStatus,
                          isDense: true,
                          isExpanded: true,
                          items: [
                            DropdownMenuItem(child: Text("Done"), value: "held"),
                          ],
                          onChanged: (newMetStatus) => {
                            setState(() {
                              metStatus = newMetStatus!;
                              // print(quality.toString());
                            }),
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10,),

                  Expanded(
                    child: TextField(
                      readOnly: true,
                      controller: meetdatetime,
                      style: TextStyle(color: Colors.black, fontSize: 16.0,),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_today, color: Colors.orange,),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        labelText: 'VC Date',
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
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          if(pickedTime != null ){
                            // print(pickedTime.format(context));   //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                            String formattedTime = DateFormat('HH:mm').format(parsedTime);
                            String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTimeField.combine(pickedDate, pickedTime));
                            setState(() {
                              meetdatetime.text = formattedDateTime;
                            });
                          }
                        }
                      },
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
                        labelText: 'Main Disp',
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: mainDisposition,
                          isDense: true,
                          isExpanded: true,
                          items: [
                            DropdownMenuItem(child: Text("Contacted"), value: "contacted"),
                          ],
                          onChanged: (newMetStatus) => {
                            setState(() {
                              mainDisposition = newMetStatus!;
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
                        labelText: 'Sub Disp',
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: subDisposition,
                          isDense: true,
                          isExpanded: true,
                          items: [
                            DropdownMenuItem(child: Text("-Select Disp-"), value: ""),
                            DropdownMenuItem(child: Text("Interested"), value: "intrested"),
                            DropdownMenuItem(child: Text("Call Back"), value: "call back"),
                            DropdownMenuItem(child: Text("DND"), value: "dnd"),
                            DropdownMenuItem(child: Text("language issue"), value: "Language Issue"),
                          ],
                          onChanged: (newMetStatus) => {
                            setState(() {
                              subDisposition = newMetStatus!;
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
                      _isButtonDisabled ? null : voiceCallDone(userToken, userId, widget.leadId);
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
        comment.text = updateleaddata[0].comment!;
      });

    }
  }


  Future<void> voiceCallDone(userToken, userId, leadId) async {
    setState(() {
      _isButtonDisabled = true;
    });
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/voicecall_done.php';
    var url = Uri.parse(apiUrl);

    var data = {
      "lead_id": leadId,
      "user_id": userId,
      "cust_name": custNameText.text,
      "meet_status": metStatus,
      "meet_date": meetdatetime.text,
      "main_dispos": mainDisposition,
      "sub_dispos": subDisposition,
      "meet_comment": comment.text,
    };

    // print(data);
    var request = jsonEncode(data);

    Response response = await http.post(
        url,
        body: request,
        headers: headersData
    );

    if (response.statusCode == 200) {
      var responseArr = jsonDecode(response.body);
      // print(responseArr); return;
      if(responseArr['rstatus'] == '1'){
        Fluttertoast.showToast(
            msg: 'Call Done Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0
        );
      }else{
        Fluttertoast.showToast(
            msg: 'Something Went Wrong!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0
        );
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Incorrect api url',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20.0
      );
    }

    setState(() {
      _isButtonDisabled = false;
    });

  }

}
