import 'dart:convert';
import 'package:crm_software/audioplayer_example.dart';
import 'package:crm_software/gloabal_variable.dart';
import 'package:crm_software/modals/callrecord_modal.dart';
import 'package:crm_software/modals/comment_modal.dart';
import 'package:crm_software/reminder_page.dart';
import 'package:crm_software/user_preference.dart';
import 'package:crm_software/whatsapp_page.dart';
import 'package:crm_software/widgets/header_section.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';
import 'modals/leadview_modal.dart';
import 'newlead_page.dart';

class LeadView extends StatefulWidget {
  final leadId;
  const LeadView({Key? key, required this.leadId}) : super(key: key);

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

  int _selectedIndex = -1;
  void onItemTaped(int index){
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 0){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(tabIndex: 0)));
      }else if(_selectedIndex == 1){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ReminderPage(tabIndex: 0)));
      }else if(_selectedIndex == 2){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(tabIndex: 0)));
      }else if(_selectedIndex == 3){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WhatsappPage()));
      }else if(_selectedIndex == 4){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NewleadPage(tabIndex: 0)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        elevation: 0,
        toolbarHeight: 45.0,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: topHeaderBar(),
        ),
      ),
      body: Container(
        // height: double.maxFinite,
        // height: MediaQuery.of(context).size.height * 0.60,
        child: ListView(
          children: [
            // TopHeader(),
            HeaderSection(),
            leadViewBody(),
          ],
        ),
      ),
      bottomNavigationBar: bottomMenue(context),
    );
  }

  Container leadViewBody() {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.70,
      color: Colors.grey,
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.elliptical(10.0, 10.0)),
            ),
            height: 92,
            child: leadviewres.isEmpty ? Center(child: CircularProgressIndicator()): Column(
              children: [
                SizedBox(
                  height: 5,
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
                        '${leadviewres[0].custName![0]}'.toUpperCase(),
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
                  '${leadviewres[0].custName}',
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
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
            height: 210,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.elliptical(10.0, 10.0)),
            ),
            child: recordings.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: recordings.length,
              itemBuilder: (context, index) {
                if(recordings[index].leadid!.isNotEmpty){
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
                }else{
                  return Container(
                    height: 100,
                    child: SizedBox(
                      height: 20,
                      child: Center(
                        child: Text(
                          'Recordings Not Available', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.red),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),

          SizedBox(height: 10,),

          Container(
            height: 210,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.elliptical(10.0, 10.0)),
            ),
            child: comments.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                if(comments[index].comment!.isNotEmpty){
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
                }else{
                  return Container(
                    height: 100,
                    child: SizedBox(
                      height: 20,
                      child: Center(
                        child: Text(
                          'Comments Not Available', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.red),
                        ),
                      ),
                    ),
                  );
                }
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
            '$apiRootUrl/view_lead.php?lead_id=$leadId'),
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
            '$apiRootUrl/lead_call.php?lead_id=$leadId'),
        headers: headersData);
    RecordingModal recordingModal = RecordingModal.fromJson(jsonDecode(response.body));
    recordings = recordings + recordingModal.audiodata!;
      setState(() {
        recordings;
      });
  }


  void getCommentData(userToken, leadId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/lead_comment.php?lead_id=$leadId'),
        headers: headersData);
    CommentModal commentModal = CommentModal.fromJson(jsonDecode(response.body));
    comments = comments + commentModal.commentdata!;
      setState(() {
        comments;
      });
  }


  Container topHeaderBar() {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 40,),
          Image.asset('assets/images/salesapp.png', width: 100),
          Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text('Live Call'.toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  SizedBox(width: 3,),
                  Icon(Icons.call),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget bottomMenue(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black12,
        currentIndex: _selectedIndex == -1 ? 0 : _selectedIndex,
        selectedItemColor: _selectedIndex == -1 ? Colors.grey : Colors.orange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.call, color: Colors.green,),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active_rounded, color: Colors.red,),
            label: 'Reminder',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green,),
            label: 'Whatsapp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_alt, color: Colors.red,),
            label: 'New Lead',
          ),
        ],
        onTap: onItemTaped,
      ),
    );
  }


}

