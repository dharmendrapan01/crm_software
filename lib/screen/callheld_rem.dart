import 'dart:convert';

import 'package:crm_software/gloabal_variable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../lead_view.dart';
import '../modals/meeting_plan_rem_modal.dart';
import '../user_preference.dart';
import '../whatsapp_chat.dart';

class CallHeldRem extends StatefulWidget {
  final searchDate;
  const CallHeldRem({Key? key, this.searchDate}) : super(key: key);

  @override
  State<CallHeldRem> createState() => _CallHeldRemState();
}

class _CallHeldRemState extends State<CallHeldRem> {
  List<Meetinglist> callhelddata = [];
  TextEditingController calldate = TextEditingController();
  // String curreCallDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int page = 1;
  bool loading = true;
  String? userToken = '';
  String? userId = '';

  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    calldate.text = widget.searchDate;
    getCallHeldData(userToken, userId, page, calldate.text);
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
        //   controller: calldate,
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
        //       calldate.text = formattedDate;
        //       setState(() {
        //         getCallHeldData(userToken, userId, page, calldate.text);
        //       });
        //     }
        //   },
        // ),

        SizedBox(height: 5,),

        Expanded(
          child: callhelddata.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: callhelddata.length,
              itemBuilder: (context, index){
                if(callhelddata[index].leadId!.isNotEmpty){
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(right: 5, left: 5),
                      title: Text(
                        '${callhelddata[index].custName}  (${callhelddata[index].leadId})',
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${callhelddata[index].nomasked}', style: TextStyle(color: Colors.black),),
                          Text(
                            '${callhelddata[index].agent}  ${callhelddata[index].leadQuality}',
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
                                    addFavorite(callhelddata[index].leadId, userToken);
                                  },
                                  child: callhelddata[index].favorite == '0' ? Icon(Icons.favorite, color: Colors.grey) : Icon(Icons.favorite, color: Colors.red),
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (context) => LeadView(leadId: callhelddata[index].leadId),
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
                                        builder: (context) => WhatsappChat(leadId: callhelddata[index].leadId, userName: callhelddata[index].custName, leadStatus: 'Call Held'),
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

  // void getCallHeldData(userToken, userId, paraPage, planDate) async {
  //   callhelddata.clear();
  //   var headersData = {
  //     "Content-type": "application/json",
  //     "Authorization": "Bearer $userToken"
  //   };
  //   var response = await http.get(
  //       Uri.parse(
  //           '$apiRootUrl/callheld_rem.php?user_id=$userId&page_no=$page&plan_date=$planDate'),
  //       headers: headersData);
  //   MeetingPlanRemModal meetingPlanRemModal = MeetingPlanRemModal.fromJson(json.decode(response.body));
  //   callhelddata = callhelddata + meetingPlanRemModal.meetinglist!;
  //   setState(() {
  //     callhelddata;
  //   });
  // }


  Future getCallHeldData(userToken, userId, paraPage, planDate) async {
    callhelddata.clear();
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/callheld_rem.php';
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
    callhelddata = callhelddata + meetingPlanRemModal.meetinglist!;
    int localPage = page + 1;
    setState(() {
      callhelddata;
      loading = false;
      page = localPage;
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
    getCallHeldData(userToken, userId, page, calldate.text);
  }


}
