import 'dart:convert';
import 'package:crm_software/audioplayer_example.dart';
import 'package:crm_software/modals/callrecord_modal.dart';
import 'package:crm_software/modals/comment_modal.dart';
import 'package:crm_software/user_preference.dart';
import 'package:crm_software/widgets/header_section.dart';
import 'package:crm_software/widgets/top_header.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'modals/leadview_modal.dart';

class LeadView extends StatefulWidget {
  var leadId;
  LeadView({Key? key, required this.leadId}) : super(key: key);

  @override
  State<LeadView> createState() => _LeadViewState();
}

class _LeadViewState extends State<LeadView> {
  List<Leaddata> leadviewres = [];
  List<Audiodata> recordings = [];
  List<Commentdata> comments = [];
  String? userToken = '';
  String? userId = '';


  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    getLeadData(userToken, widget.leadId);
    getAudioData(userToken, widget.leadId);
    getCommentData(userToken, widget.leadId);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TopHeader(),
          HeaderSection(),
          leadViewBody(),
        ],
      ),
    );
  }

  leadViewBody() {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.elliptical(10.0, 10.0)),
            ),
            height: 100,
            child: ListView.builder(
              itemCount: leadviewres.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(50),
                      shadowColor: Colors.black,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 30.0,
                        child: CircleAvatar(
                          radius: 27.0,
                          backgroundColor: Colors.orange,
                          child: Text(
                            '${leadviewres[index].custName![0]}'.toUpperCase(),
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${leadviewres[index].custName}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                );
              },
            ),
          ),

          SizedBox(height: 10,),

          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.elliptical(10.0, 10.0)),
            ),
            child: ListView.builder(
              padding: EdgeInsets.only(top: 15.0),
              itemCount: leadviewres.length,
              itemBuilder: (context, index) {
                return Text(
                  '   ${leadviewres[index].datatype} (${leadviewres[index].leadId}) (${leadviewres[index].leadQuality}) (${leadviewres[index].budget})',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                );
              },
            ),
          ),

          SizedBox(height: 10,),

          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.elliptical(10.0, 10.0)),
            ),
            child: ListView.builder(
              padding: EdgeInsets.only(top: 15.0),
              itemCount: leadviewres.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '   +91${leadviewres[index].nomasked}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 190,),
                    leadviewres[index].temprature == '1' ? Icon(Icons.fireplace_outlined, color: Colors.red,) :

                    SizedBox(width: 10,),

                    leadviewres[index].svcount != '0' ? Icon(Icons.handshake_outlined, color: Colors.red,) :

                    SizedBox(width: 10,),

                    leadviewres[index].svcount != '0' ? Text('${leadviewres[index].svcount}   ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red)) : Text('', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red)),
                  ],
                );
              },
            ),
          ),

          SizedBox(height: 10,),

          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.elliptical(10.0, 10.0)),
            ),
            child: recordings.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
              itemCount: recordings.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      ListTile(
                        leading: (recordings[index].calldirection == 'clicktocall' || recordings[index].calldirection == 'callbroadcast') && recordings[index].callstatus == 'answered' ? Icon(Icons.call_made, color: Colors.green) : (recordings[index].calldirection == 'clicktocall' || recordings[index].calldirection == 'callbroadcast') && recordings[index].callstatus == 'missed' ? Icon(Icons.call_made, color: Colors.red) : recordings[index].calldirection == 'inbound' && recordings[index].callstatus == 'missed' ? Icon(Icons.call_received, color: Colors.red) : Icon(Icons.call_received, color: Colors.green),
                        title: recordings[index].calldirection == 'clicktocall' || recordings[index].calldirection == 'callbroadcast' ? Text('Outgoing: ${recordings[index].callduration}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),) : Text('Incoming: ${recordings[index].callduration}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text('${recordings[index].calldate},  ${recordings[index].callednumber}', style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: (){
                            showModalBottomSheet(
                              // enableDrag: false,
                              // isDismissible: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              context: context,
                              builder: (context) => AudioExample(audioUrl: recordings[index].audiourl.toString()),
                            );
                          },
                          icon: Icon(Icons.play_arrow_rounded, size: 40.0, color: Colors.black,),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 10,),

          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.elliptical(10.0, 10.0)),
            ),
            child: comments.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      '${comments[index].calldate}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    subtitle: Text(
                      '${comments[index].comment}',
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  void getLeadData(userToken, leadId) async {
    // print(leadId);
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            'https://spaze-salesapp.com/app/_api/view_lead.php?lead_id=$leadId'),
        headers: headersData);
    // print(response.body);
    LeadViewModal leadDataClass =
        LeadViewModal.fromJson(jsonDecode(response.body));
    leadviewres = leadviewres + leadDataClass.leaddata!;
    setState(() {
      leadviewres;
    });
  }


  void getAudioData(userToken, leadId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            'https://spaze-salesapp.com/app/_api/lead_call.php?lead_id=$leadId'),
        headers: headersData);
    RecordingModal recordingModal = RecordingModal.fromJson(jsonDecode(response.body));
    recordings = recordings + recordingModal.audiodata!;
    if(recordings.isEmpty){
      Fluttertoast.showToast(
          msg: 'Data Not Available',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20.0
      );
    }else{
      setState(() {
        recordings;
      });
    }
  }


  void getCommentData(userToken, leadId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            'https://spaze-salesapp.com/app/_api/lead_comment.php?lead_id=$leadId'),
        headers: headersData);
    CommentModal commentModal = CommentModal.fromJson(jsonDecode(response.body));
    comments = comments + commentModal.commentdata!;
    if(comments.isEmpty){
      Fluttertoast.showToast(
          msg: 'Data Not Available',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20.0
      );
    }else{
      setState(() {
        comments;
      });
    }
  }


}

