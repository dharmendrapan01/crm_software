import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../gloabal_variable.dart';
import '../modals/agentlist_modal.dart';
import '../user_preference.dart';

class LiveCallTransfer extends StatefulWidget {
  final callId;
  const LiveCallTransfer({Key? key, this.callId}) : super(key: key);

  @override
  State<LiveCallTransfer> createState() => _LiveCallTransferState();
}

class _LiveCallTransferState extends State<LiveCallTransfer> {
  List<Agentlist> agentlist = [];
  String? userToken = '';
  String? userId = '';

  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    getAgentList(userId, userToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15,),
          Text('Choose one of the below agent', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
          SizedBox(height: 15,),
          
          agentlist.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: agentlist.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Text('${agentlist[index].name}'),
                  title: Text('${agentlist[index].followMeNumber}'),
                  trailing: ElevatedButton(
                      onPressed: () {
                        liveCallTransfer(4, widget.callId, agentlist[index].id, agentlist[index].intercom, userToken);
                      },
                      child: Text('Transfer'),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future getAgentList(String? userId, String? userToken) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(Uri.parse('$apiRootUrl/agent_list.php?user_id=$userId'), headers: headersData);
    // print(response);
    AgentListModal agentListModal = AgentListModal.fromJson(json.decode(response.body));
    agentlist = agentlist + agentListModal.agentlist!;
    setState(() {
      agentlist;
    });
  }


  Future<void> liveCallTransfer(option, callId, agentId, intercomId, userToken) async {
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
      "agent_no": agentId,
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
