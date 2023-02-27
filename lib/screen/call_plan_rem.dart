import 'dart:convert';

import 'package:crm_software/gloabal_variable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../lead_view.dart';
import '../modals/meeting_plan_rem_modal.dart';
import '../user_preference.dart';
import '../whatsapp_chat.dart';

class CallPlanRem extends StatefulWidget {
  final searchDate;
  const CallPlanRem({Key? key, this.searchDate}) : super(key: key);

  @override
  State<CallPlanRem> createState() => _CallPlanRemState();
}

class _CallPlanRemState extends State<CallPlanRem> {
  List<Meetinglist> callplandata = [];
  TextEditingController callplandate = TextEditingController();
  // String curreCallDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int page = 1;
  bool loading = true;
  String? userToken = '';
  String? userId = '';

  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    callplandate.text = widget.searchDate;
    getCallPlanData(userToken, userId, page, callplandate.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        // TextField(
        //   readOnly: true,
        //   controller: callplandate,
        //   style: TextStyle(color: Colors.black, fontSize: 16.0,),
        //   decoration: InputDecoration(
        //     suffixIcon: Icon(Icons.calendar_today, color: Colors.orange,),
        //     contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
        //     hintText: 'Search by date',
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(8)),
        //     ),
        //   ),
        //
        //   onTap: () async {
        //     DateTime? pickedDate =  await showDatePicker(
        //         context: context,
        //         initialDate: DateTime.now(),
        //         firstDate: DateTime(1900),
        //         lastDate: DateTime(2100)
        //     );
        //     if(pickedDate != null){
        //       String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        //       callplandate.text = formattedDate;
        //       setState(() {
        //         getCallPlanData(userToken, userId, page, callplandate.text);
        //       });
        //     }
        //   },
        // ),

        SizedBox(height: 5,),

        Expanded(
            child: callplandata.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: callplandata.length,
                itemBuilder: (context, index){
                  if(callplandata[index].leadId!.isNotEmpty){
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(right: 5, left: 5),
                        title: Text(
                          '${callplandata[index].custName}  (${callplandata[index].leadId})',
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${callplandata[index].nomasked}', style: TextStyle(color: Colors.black),),
                            Text(
                              '${callplandata[index].agent}  ${callplandata[index].leadQuality}',
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                          ),
                          width: 70,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 5,),
                                  InkWell(
                                    onTap: () {
                                      callPlanDelete(callplandata[index].meetingId, userToken, userId);
                                    },
                                    child: Icon(Icons.delete, color: Colors.red),
                                  ),
                                  SizedBox(width: 10,),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context, MaterialPageRoute(
                                          builder: (context) => LeadView(leadId: callplandata[index].leadId),
                                        ),
                                        );
                                      },
                                      child: Icon(Icons.remove_red_eye, color: Colors.orange,)),
                                ],
                              ),
                              SizedBox(height: 3,),
                              Row(
                                children: [
                                  SizedBox(width: 5,),
                                  Icon(Icons.emoji_emotions_outlined, color: Colors.blue,),
                                  SizedBox(width: 10,),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context, MaterialPageRoute(
                                          builder: (context) => WhatsappChat(leadId: callplandata[index].leadId, userName: callplandata[index].custName, leadStatus: 'Call Planned'),
                                        ),
                                        );
                                      },
                                      child: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green,)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }else{
                    return Container(
                        margin: EdgeInsets.only(top: 200),
                        child: Center(child: Text('Data not found', style: TextStyle(fontSize: 18, color: Colors.red),)));
                  }
                }
            ),
        ),
      ],
    );
  }

  void getCallPlanData(userToken, userId, paraPage, planDate) async {
    // print('$apiRootUrl');
    // print(userToken);
    callplandata.clear();
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/callplan_rem.php?user_id=$userId&page_no=$page&plan_date=$planDate'),
        headers: headersData);
    // print(response.body);
    MeetingPlanRemModal meetingPlanRemModal = MeetingPlanRemModal.fromJson(json.decode(response.body));
    callplandata = callplandata + meetingPlanRemModal.meetinglist!;
    // print(result);
    // int localPage = page + 1;
    setState(() {
      callplandata;
      loading = false;
      // page = localPage;
    });
  }


  void callPlanDelete(meetingId, userToken, userId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var reqParameter = {
      "call_id": "$meetingId",
      "user_id": "$userId"
    };
    var response = await http.post(Uri.parse('$apiRootUrl/callplan_delete.php'), headers: headersData, body: jsonEncode(reqParameter));
    if(response.statusCode == 200){
      var responseArr = jsonDecode(response.body);
      if(responseArr['status'] == '1'){
        Fluttertoast.showToast(
            msg: 'Call deleted',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0
        );
      }else{
        Fluttertoast.showToast(
            msg: 'Something went wrong',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0
        );
      }
      getCallPlanData(userToken, userId, page, callplandate.text);
    }
  }

}
