import 'dart:async';
import 'dart:convert';
import 'package:crm_software/gloabal_variable.dart';
import 'package:crm_software/user_preference.dart';
import 'package:crm_software/widgets/download_dialog.dart';
import 'package:crm_software/widgets/googlemap_screen.dart';
import 'package:crm_software/widgets/video_play.dart';
import 'package:crm_software/widgets/whatsapp_attachment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'audioplayer_example.dart';
import 'modals/whatsappchat_modal.dart';

class WhatsappChat extends StatefulWidget {
  final leadId;
  final userName;
  final leadStatus;

  const WhatsappChat({Key? key, this.leadId, this.userName, this.leadStatus}) : super(key: key);

  @override
  State<WhatsappChat> createState() => _WhatsappChatState();
}

class _WhatsappChatState extends State<WhatsappChat> {
  List<Whatsappchat> whatsappchats = [];
  String? userToken = '';
  String? userId = '';
  bool isLoading = false;
  TextEditingController textMsg = TextEditingController();
  ScrollController _scrollController = ScrollController();
  Timer? timer;

  @override
  void initState() {
    userToken = UserPreference.getUserToken() ?? '';
    userId = UserPreference.getUserId() ?? '';
    getChat(userToken, widget.leadId);

    // fetchBottomPage();
    // scrollToBottom();
    // _goToBottomPage();

    // timer = Timer.periodic(Duration(seconds: 5), (Timer t) => setState(() {
    //   getChat(userToken, widget.leadId);
    // })
    // );

    super.initState();
    // print(_scrollController.hasClients);
    // _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  // void scrollToBottom() {
  //   final bottomOffset = _scrollController.position.maxScrollExtent;
  //   _scrollController.animateTo(
  //     bottomOffset,
  //     duration: Duration(milliseconds: 1000),
  //     curve: Curves.easeInOut,
  //   );
  // }

  // void fetchBottomPage() {
  //   _scrollController.addListener(() async {
  //       _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 1), curve: Curves.easeOut);
  //   });
  // }

  @override
  void dispose() {
    timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        elevation: 0,
        toolbarHeight: 45.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: topHeaderBar(),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgimagewh.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
                child: whatsappchats.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
                    controller: _scrollController,
                    itemCount: whatsappchats.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 5,bottom: 5),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index){
                      if(whatsappchats[index].whdirection!.isNotEmpty){
                        if(index == whatsappchats.length){
                          return Container(
                            height: 50,
                          );
                        }
                        return Container(
                          // height: 70,
                          padding: EdgeInsets.all(5),
                          child: Align(
                            alignment: whatsappchats[index].whdirection == 'incoming' ? Alignment.topLeft : Alignment.topRight,
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 340,
                              ),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: whatsappchats[index].whdirection == 'incoming' ? Colors.grey.shade200 : Colors.green.shade50,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: whatsappchats[index].whtype == 'text' ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${whatsappchats[index].whtext}',
                                        style: TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.italic),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        // mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('${whatsappchats[index].createdate}', style: TextStyle(color: Colors.blue)),

                                          whatsappchats[index].whdirection == 'outgoing' ? SizedBox(width: 5,) : SizedBox(width: 0,),
                                          whatsappchats[index].whdirection == 'outgoing' ? whatsappchats[index].whStatus == '25' ? Icon(Icons.done, color: Colors.grey, size: 20,) : whatsappchats[index].whStatus == '0' ? Icon(Icons.done_all, color: Colors.grey, size: 20,) : whatsappchats[index].whStatus == '26' ? Icon(Icons.done_all, color: Colors.blue, size: 20,) : Icon(Icons.done, color: Colors.grey, size: 20,) : SizedBox(width: 0,),
                                        ],
                                      ),
                                    ],
                                  ) : whatsappchats[index].whtype == 'image' ? Column(
                                    children: [
                                      Image(image: NetworkImage('${whatsappchats[index].whfile}'),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        // mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('${whatsappchats[index].createdate}', style: TextStyle(color: Colors.blue)),
                                          whatsappchats[index].whdirection == 'outgoing' ? SizedBox(width: 5,) : SizedBox(width: 0,),
                                          whatsappchats[index].whdirection == 'outgoing' ? whatsappchats[index].whStatus == '25' ? Icon(Icons.done, color: Colors.grey, size: 20,) : whatsappchats[index].whStatus == '0' ? Icon(Icons.done_all, color: Colors.grey, size: 20,) : whatsappchats[index].whStatus == '26' ? Icon(Icons.done_all, color: Colors.blue, size: 20,) : Icon(Icons.done, color: Colors.grey, size: 20,) : SizedBox(width: 0,),
                                        ],
                                      ),
                                    ],
                                  ) : whatsappchats[index].whtype == 'video' ? Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.black,
                                        ),
                                        height: 200,
                                        width: double.maxFinite,
                                        child: IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                              ),
                                              context: context,
                                              builder: (context) => VideoPlay(videoUrl: whatsappchats[index].whfile),
                                            );
                                          },
                                          icon: Icon(Icons.play_arrow, size: 50, color: Colors.white,),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text('${whatsappchats[index].createdate}', style: TextStyle(color: Colors.blue)),
                                          whatsappchats[index].whdirection == 'outgoing' ? SizedBox(width: 5,) : SizedBox(width: 0,),
                                          whatsappchats[index].whdirection == 'outgoing' ? whatsappchats[index].whStatus == '25' ? Icon(Icons.done, color: Colors.grey, size: 20,) : whatsappchats[index].whStatus == '0' ? Icon(Icons.done_all, color: Colors.grey, size: 20,) : whatsappchats[index].whStatus == '26' ? Icon(Icons.done_all, color: Colors.blue, size: 20,) : Icon(Icons.done, color: Colors.grey, size: 20,) : SizedBox(width: 0,),
                                        ],
                                      ),
                                    ],
                                  ) : whatsappchats[index].whtype == 'audio' ? Column(
                                    children: [
                                      InkWell(
                                        child: Image.asset('assets/images/audioplayer.png'),
                                        onTap: () {
                                          showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                            ),
                                            context: context,
                                            builder: (context) => AudioExample(audioUrl: whatsappchats[index].whfile.toString()),
                                          );
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text('${whatsappchats[index].createdate}', style: TextStyle(color: Colors.blue)),
                                          whatsappchats[index].whdirection == 'outgoing' ? SizedBox(width: 5,) : SizedBox(width: 0,),
                                          whatsappchats[index].whdirection == 'outgoing' ? whatsappchats[index].whStatus == '25' ? Icon(Icons.done, color: Colors.grey, size: 20,) : whatsappchats[index].whStatus == '0' ? Icon(Icons.done_all, color: Colors.grey, size: 20,) : whatsappchats[index].whStatus == '26' ? Icon(Icons.done_all, color: Colors.blue, size: 20,) : Icon(Icons.done, color: Colors.grey, size: 20,) : SizedBox(width: 0,),
                                        ],
                                      ),
                                    ],
                                  ) : whatsappchats[index].whtype == 'location' ? InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => GooglemapScreen(latitude: whatsappchats[index].loclat!.toDouble(), langitude: whatsappchats[index].localang!.toDouble())));
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset('assets/images/googlemap.jpg'),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('${whatsappchats[index].createdate}', style: TextStyle(color: Colors.blue)),
                                            whatsappchats[index].whdirection == 'outgoing' ? SizedBox(width: 5,) : SizedBox(width: 0,),
                                            whatsappchats[index].whdirection == 'outgoing' ? whatsappchats[index].whStatus == '25' ? Icon(Icons.done, color: Colors.grey, size: 20,) : whatsappchats[index].whStatus == '0' ? Icon(Icons.done_all, color: Colors.grey, size: 20,) : whatsappchats[index].whStatus == '26' ? Icon(Icons.done_all, color: Colors.blue, size: 20,) : Icon(Icons.done, color: Colors.grey, size: 20,) : SizedBox(width: 0,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ) : whatsappchats[index].whtype == 'document' ? GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => DownloadingDialog(downloadUrl: whatsappchats[index].whfile),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset('assets/images/whpdf.png', fit: BoxFit.fill,),
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.55,
                                                child: Text('${whatsappchats[index].filename}',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Icon(Icons.download, size: 25, color: Colors.black,),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('${whatsappchats[index].createdate}', style: TextStyle(color: Colors.blue)),
                                            whatsappchats[index].whdirection == 'outgoing' ? SizedBox(width: 5,) : SizedBox(width: 0,),
                                            whatsappchats[index].whdirection == 'outgoing' ? whatsappchats[index].whStatus == '25' ? Icon(Icons.done, color: Colors.grey, size: 20,) : whatsappchats[index].whStatus == '0' ? Icon(Icons.done_all, color: Colors.grey, size: 20,) : whatsappchats[index].whStatus == '26' ? Icon(Icons.done_all, color: Colors.blue, size: 20,) : Icon(Icons.done, color: Colors.grey, size: 20,) : SizedBox(width: 0,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )  : Text('${whatsappchats[index].whtext}'),
                                ),
                              ),
                            ),
                          ),
                        );
                      }else{
                        return Container(
                            margin: EdgeInsets.only(top: 100),
                            child: Center(child: Text('Data not found', style: TextStyle(fontSize: 20, color: Colors.red),)));
                      }
                    }
                ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                // height: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            showModalBottomSheet(
                              enableDrag: true,
                              isDismissible: true,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              context: context,
                              builder: (context) => WhatsappAttachment(leadId: widget.leadId),
                            );
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(Icons.attach_file, color: Colors.white, size: 20, ),
                          ),
                        ),

                        SizedBox(width: 15.0,),

                        Expanded(
                          child: TextField(
                            controller: textMsg,
                            decoration: InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none
                            ),
                          ),
                        ),

                        SizedBox(width: 15,),

                        Container(
                          height: 40,
                          width: 40,
                          child: FloatingActionButton(
                              onPressed: (){
                                _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                                sendTextMsg(userToken, userId, widget.leadId);
                                textMsg.clear();
                              },
                              child: Icon(Icons.send,color: Colors.white,size: 18,),
                              backgroundColor: Colors.green,
                              elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Container topHeaderBar() {
    return Container(
      color: Colors.black,
      child: widget.userName == '' ? Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2,))) : Row(
        children: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: Colors.green,),
          ),
          SizedBox(width: 2.0,),
          CircleAvatar(
            backgroundColor: Colors.blueGrey,
            maxRadius: 20.0,
            child: Text('${widget.userName[0]}', style: TextStyle(color: Colors.white),),
          ),
          SizedBox(width: 12,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.38,
                child: Text(
                  '${widget.userName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 2,),
              Text('${widget.leadStatus}', style: TextStyle(color: Colors.white),),
            ],
          ),

          SizedBox(width: 2,),
          IconButton(
              onPressed: () {
                setState(() {
                  getChat(userToken, widget.leadId);
                });
              }, 
              icon: Icon(Icons.refresh, color: Colors.white,)
          ),
          SizedBox(width: 2,),
          Image.asset('assets/images/salesapp.png', width: 80),
        ],
      ),
    );
  }


  Future<void> sendTextMsg(userToken, userId, leadId) async {
    // AlertDialog alertDialog = AlertDialog(
    //   content: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Center(child: CircularProgressIndicator()),
    //     ],
    //   ),
    // );
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (context) {
    //     return alertDialog;
    //   },
    // );
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/send_textmsg.php';
    var url = Uri.parse(apiUrl);
    var data = {
      "lead_id": leadId,
      "user_id": userId,
      "text_msg": textMsg.text,
    };
    var request = jsonEncode(data);

    http.Response response = await http.post(
        url,
        body: request,
        headers: headersData
    );

    // Navigator.pop(context);

    if (response.statusCode == 200) {
      var responseArr = jsonDecode(response.body);
      if(responseArr['status'] == '1'){
        getChat(userToken, widget.leadId);
        // Fluttertoast.showToast(
        //     msg: 'Detail has been sent',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     backgroundColor: Colors.green,
        //     textColor: Colors.white,
        //     fontSize: 20.0
        // );
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


  void getChat(userToken, leadId) async {
    whatsappchats.clear();
    // print('object');
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/whatsapp_chat.php?lead_id=$leadId'),
        headers: headersData);
    WhatsappchatModal chatModal = WhatsappchatModal.fromJson(json.decode(response.body));
    whatsappchats = whatsappchats + chatModal.whatsappchat!;
    setState(() {
      whatsappchats;
    });
  }

  // void _goToBottomPage() {
  //   if(_scrollController.hasClients){
  //     _scrollController.animateTo(
  //       _scrollController.position.maxScrollExtent,
  //       duration: Duration(milliseconds: 1),
  //       curve: Curves.easeInOut
  //     );
  //   }
  // }


}
