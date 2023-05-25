import 'dart:convert';

import 'package:crm_software/gloabal_variable.dart';
import 'package:crm_software/screen/update_meeting.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../lead_view.dart';
import '../modals/meeting_plan_rem_modal.dart';
import '../user_preference.dart';
import '../whatsapp_chat.dart';

class MeetingPlanRem extends StatefulWidget {
  final searchDate;
  const MeetingPlanRem({Key? key, this.searchDate}) : super(key: key);

  @override
  State<MeetingPlanRem> createState() => _MeetingPlanRemState();
}

class _MeetingPlanRemState extends State<MeetingPlanRem> {
  List<Meetinglist> meetingplan = [];
  TextEditingController meetingdate = TextEditingController();
  int page = 1;
  bool loading = true;
  String? userToken = '';
  String? userId = '';
  // String curreMeetDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    meetingdate.text = widget.searchDate;
    getMeetingPlanData(userToken, userId, page, meetingdate.text);
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
        SizedBox(height: 5,),

        Expanded(
          child: meetingplan.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: meetingplan.length,
              itemBuilder: (context, index){
                if(meetingplan[index].leadId!.isNotEmpty){
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(right: 5, left: 5),
                      leading: Container(
                        width: 50,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                meetingConfirm(meetingplan[index].meetingId, userToken, userId);
                              },
                              child: meetingplan[index].metstatus == 'planned' ? Icon(Icons.close, color: Colors.red, size: 30,) : Icon(Icons.done, color: Colors.green, size: 30,),
                            ),
                            InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => UpdateMeeting(leadId: meetingplan[index].leadId, meetingId: meetingplan[index].meetingId),
                                  );
                                },
                                child: Icon(Icons.handshake_outlined, color: Colors.blue,)),
                          ],
                        ),
                      ),
                      title: Text(
                        '${meetingplan[index].custName}  (${meetingplan[index].leadId})',
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${meetingplan[index].nomasked}', style: TextStyle(color: Colors.black),),
                          Text(
                            '${meetingplan[index].agent}  ${meetingplan[index].leadQuality}',
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
                                    meetingDelete(meetingplan[index].meetingId, userToken, userId);
                                  },
                                  child: Icon(Icons.delete, color: Colors.red),
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (context) => LeadView(leadId: meetingplan[index].leadId),
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
                                        builder: (context) => WhatsappChat(leadId: meetingplan[index].leadId, userName: meetingplan[index].custName, leadStatus: meetingplan[index].metstatus),
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


  // void getMeetingPlanData(userToken, userId, paraPage, planDate) async {
  //   // print(planDate);
  //   // print(userToken);
  //   meetingplan.clear();
  //   var headersData = {
  //     "Content-type": "application/json",
  //     "Authorization": "Bearer $userToken"
  //   };
  //   var response = await http.get(
  //       Uri.parse(
  //           '$apiRootUrl/meeting_plan_rem.php?user_id=$userId&page_no=$page&plan_date=$planDate'),
  //       headers: headersData);
  //   // print(response.body);
  //   MeetingPlanRemModal meetingPlanRemModal = MeetingPlanRemModal.fromJson(json.decode(response.body));
  //   // print(userClass);
  //   meetingplan = meetingplan + meetingPlanRemModal.meetinglist!;
  //   // print(result);
  //   // int localPage = page + 1;
  //   setState(() {
  //     meetingplan;
  //     loading = false;
  //     // page = localPage;
  //   });
  // }


  Future getMeetingPlanData(userToken, userId, paraPage, planDate) async {
    meetingplan.clear();
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/meeting_plan_rem.php';
    var url = Uri.parse(apiUrl);

    var data = {
      "user_id": userId,
      "page_no": page,
      "plan_date": planDate,
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
    MeetingPlanRemModal meetingPlanRemModal = MeetingPlanRemModal.fromJson(json.decode(response.body));
    meetingplan = meetingplan + meetingPlanRemModal.meetinglist!;
    int localPage = page + 1;
    setState(() {
      meetingplan;
      loading = false;
      page = localPage;
    });
  }


  void meetingConfirm(meetingId, userToken, userId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var reqParameter = {
      "meeting_id": "$meetingId",
      "user_id": "$userId"
    };
    var response = await http.post(Uri.parse('$apiRootUrl/meeting_confirm.php'), headers: headersData, body: jsonEncode(reqParameter));
    if(response.statusCode == 200){
      var responseArr = jsonDecode(response.body);
      if(responseArr['status'] == '1'){
        Fluttertoast.showToast(
            msg: 'Meeting confirmed',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0
        );
      }else{
        Fluttertoast.showToast(
            msg: 'Meeting already confirmed',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0
        );
      }
      getMeetingPlanData(userToken, userId, page, meetingdate.text);
    }
    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage(tabIndex: 0,)), (Route<dynamic> route) => false);
  }


  void meetingDelete(meetingId, userToken, userId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var reqParameter = {
      "meeting_id": "$meetingId",
      "user_id": "$userId"
    };
    var response = await http.post(Uri.parse('$apiRootUrl/meeting_delete.php'), headers: headersData, body: jsonEncode(reqParameter));
    if(response.statusCode == 200){
      var responseArr = jsonDecode(response.body);
      if(responseArr['status'] == '1'){
        Fluttertoast.showToast(
            msg: 'Meeting deleted',
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
      getMeetingPlanData(userToken, userId, page, meetingdate.text);
    }
  }

}
