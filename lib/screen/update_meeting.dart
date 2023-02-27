import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../gloabal_variable.dart';
import '../reminder_page.dart';
import '../user_preference.dart';

class UpdateMeeting extends StatefulWidget {
  final leadId;
  final meetingId;
  const UpdateMeeting({Key? key, this.leadId, this.meetingId}) : super(key: key);

  @override
  State<UpdateMeeting> createState() => _UpdateMeetingState();
}

class _UpdateMeetingState extends State<UpdateMeeting> {
  TextEditingController meetleadid = TextEditingController();
  TextEditingController comment = TextEditingController();
  String meetingstatus = 'held';
  String? userToken = '';
  String? userId = '';

  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    meetleadid.text = widget.leadId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.40,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5,),

              Text('Update Meeting Status', style: TextStyle(fontSize: 18, color: Colors.blue),),

              SizedBox(height: 20,),
              TextFormField(
                readOnly: true,
                controller: meetleadid,
                style: TextStyle(color: Colors.black, fontSize: 16.0,),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  labelText: 'Lead Id',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              TextFormField(
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
              ),

              SizedBox(height: 20,),

              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Meeting Status',
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: meetingstatus,
                    isDense: true,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(child: Text("Met"), value: "held"),
                      DropdownMenuItem(child: Text("Not Met"), value: "not_held"),
                    ],
                    onChanged: (newMetStatus) => {
                      setState(() {
                        meetingstatus = newMetStatus!;
                        print(newMetStatus.toString());
                      }),
                    },
                  ),
                ),
              ),

              SizedBox(height: 20,),

              ElevatedButton(
                onPressed: () {
                  updateMeetStatus(userToken, userId, widget.meetingId, widget.leadId);
                },
                child: Text('SUBMIT', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
              ),

              SizedBox(height: 20,),
            ],
          ),
        )
      ),
    );
  }


  Future<void> updateMeetStatus(userToken, userId, meetingId, leadId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/meeting_update.php';
    var url = Uri.parse(apiUrl);
    var data = {
      "lead_id": leadId,
      "meeting_id": meetingId,
      "user_id": userId,
      "meeting_status": meetingstatus,
      "meeting_comment": comment.text,
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
            msg: 'Meeting Updated Successfully',
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

    Navigator.pop(context);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReminderPage()));

  }

}
