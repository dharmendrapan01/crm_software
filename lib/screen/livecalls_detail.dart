import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../gloabal_variable.dart';
import '../lead_view.dart';
import '../modals/livecall_modal.dart';
import '../user_preference.dart';
import 'livecall_transfer.dart';

class LiveCallsDetail extends StatefulWidget {
  const LiveCallsDetail({Key? key}) : super(key: key);

  @override
  State<LiveCallsDetail> createState() => _LiveCallsDetailState();
}

class _LiveCallsDetailState extends State<LiveCallsDetail> {
  List<Response> result = [];
  String? userToken = '';
  String? userId = '';
  bool loading = true;
  int? agent_no = 0;
  String? lead_id = '';
  String? customer_name = '';
  String? login_id = '';
  String? agent_id = '';
  String? dept_id = '';
  int? leader_count = 0;
  String? intercom_id = '';
  Timer? timer;

  @override
  void initState() {
    super.initState();
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    getLiveCallData(userToken, userId);

    timer = Timer.periodic(
      Duration(seconds: 60), (Timer t) => setState(() {
      getLiveCallData(userToken, userId);
    })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(bottom: 50),
        // color: Colors.grey,
        child: loading ? Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: result.length,
            itemBuilder: (context, index) {
            // print(result.length);
              if(result[index].userId == 0){
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Text('Data Not Found', style: TextStyle(fontSize: 18, color: Colors.red),),
                  ),
                );
              }else{
                if(login_id == agent_id || dept_id == 5 || leader_count! > 0){
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          // contentPadding: EdgeInsets.zero,
                          leading: result[index].direction == 1 ? Icon(Icons.call_received, color: Colors.green,) : Icon(Icons.call_made, color: Colors.green,),
                          title: lead_id == null ? Text('Waiting...', style: TextStyle(fontSize: 16, color: Colors.black),) : InkWell(
                              onTap: (){
                                Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) => LeadView(leadId: lead_id),
                                ),
                                );
                              },
                              child: Text('$lead_id ($customer_name)', style: TextStyle(fontSize: 16, color: Colors.black),)),
                          subtitle: Text('${result[index].agentName} (${result[index].callTime})', style: TextStyle(color: Colors.black),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                liveCallOptionsDir(1, result[index].callId, agent_no, intercom_id, userToken);
                              },
                              child: Text('Monitor'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                liveCallOptionsDir(2, result[index].callId, agent_no, intercom_id, userToken);
                              },
                              child: Text('Whisper'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                liveCallOptionsDir(3, result[index].callId, agent_no, intercom_id, userToken);
                              },
                              child: Text('Barge'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  enableDrag: true,
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  ),
                                  context: context,
                                  builder: (context) => LiveCallTransfer(callId: result[index].callId,),
                                );
                              },
                              child: Text('Transfer'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }
            }
        ),
      ),
    );
  }

  void getLiveCallData(userToken, userId) async {
    // print(userId);
    result.clear();
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/livecalls_api.php?user_id=$userId'),
        headers: headersData);
    LiveCallModal liveCallModal = LiveCallModal.fromJson(json.decode(response.body));
    result = result + liveCallModal.response!;
    agent_no = liveCallModal.response2?.agentNo;
    lead_id = liveCallModal.response1?.leadId;
    customer_name = liveCallModal.response1?.customerName;
    login_id = liveCallModal.response1?.loginId;
    agent_id = liveCallModal.response1?.agentId;
    dept_id = liveCallModal.response1?.deptId;
    leader_count = liveCallModal.response1?.leaderCount;
    intercom_id = liveCallModal.response2?.intercomId;
    setState(() {
      loading = false;
      result;
      lead_id;
      customer_name;
      login_id;
      agent_id;
      dept_id;
      leader_count;
      agent_no;
      intercom_id;
    });
  }

  Future<void> liveCallOptionsDir(option, callId, agentNo, intercomId, userToken) async {
    Fluttertoast.showToast(
        msg: 'Connecting...',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20.0
    );
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/livecallpath.php';
    var url = Uri.parse(apiUrl);
    var data = {
      "option": option,
      "call_id": callId,
      "agent_no": agentNo,
      "intercom_id": intercomId,
    };
    var request = jsonEncode(data);
    http.Response response = await http.post(
        url,
        body: request,
        headers: headersData
    );

    if (response.statusCode == 200) {
      var responseArr = jsonDecode(response.body);
      if(responseArr['status'] == '1'){
        Fluttertoast.showToast(
            msg: 'Connected...',
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

  }


}
