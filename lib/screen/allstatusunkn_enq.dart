import 'dart:convert';

import 'package:crm_software/status_unknwn_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../gloabal_variable.dart';
import '../lead_view.dart';
import '../modals/cli_number.dart';
import '../modals/enquiry_modal.dart';
import '../user_preference.dart';
import '../whatsapp_chat.dart';
import '../widgets/lead_update.dart';

class AllStatusUnknEnq extends StatefulWidget {
  const AllStatusUnknEnq({Key? key}) : super(key: key);

  @override
  State<AllStatusUnknEnq> createState() => _AllStatusUnknEnqState();
}

class _AllStatusUnknEnqState extends State<AllStatusUnknEnq> {
  List<Enqlist> result = [];
  List<Clilist> clinumber = [];
  ScrollController scrollController = ScrollController();
  bool loading = true;
  int page = 1;
  String? userToken = '';
  String? userId = '';

  @override
  void initState() {
    super.initState();
    fetchNextPage();
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    getEnqData(userToken, userId, page);
    getCLI(userId, userToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        child: result.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: loading ? result.length +1 : result.length,
          itemBuilder: (context, index) {
            if(index < result.length){
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        '${result[index].cname} (${result[index].leadId}) SV-${result[index].svcount} | M-${result[index].metcount} | #${result[index].ducount}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            enableDrag: false,
                            isDismissible: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            context: context,
                            builder: (context) => cliSheet(result[index].mobile, result[index].leadId),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${result[index].nomasked}', style: TextStyle(color: Colors.black),),
                            Text('(${result[index].dataType}) (${result[index].lQuality}) (${result[index].lbudget})', style: TextStyle(color: Colors.black),),
                            Text('(${result[index].assignto}) (${result[index].duplicacy})', maxLines: 1, style: TextStyle(color: Colors.black),),
                            Text('${result[index].cdate} | ${result[index].mdate}', style: TextStyle(color: Colors.black),),
                            Text('Source:- ${result[index].source} | Project:- ${result[index].project}', style: TextStyle(color: Colors.black),),
                          ],
                        ),
                      ),
                      // trailing: Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     InkWell(
                      //        onTap: () {
                      //
                      //        },
                      //       child: Icon(Icons.event_note, size: 28, color: Colors.blue,),
                      //     ),
                      //     Icon(Icons.audio_file_outlined, size: 28, color: Colors.green,),
                      //   ],
                      // ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => LeadView(leadId: result[index].leadId),
                            ),
                            );
                          },
                          child: Image.asset('assets/images/view.png', width: 35, height: 35,),
                        ),
                        InkWell(
                          onTap: (){
                            showModalBottomSheet(
                              enableDrag: false,
                              isDismissible: false,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              context: context,
                              builder: (context) => LeadUpdate(leadId: result[index].leadId),
                            );
                          },
                          child: Image.asset('assets/images/plus.png', width: 35, height: 35,),
                        ),
                        InkWell(
                          onTap: () {
                            addFavorite(result[index].leadId, userToken);
                          },
                          child: result[index].favorite == '1' ? Image.asset('assets/images/impclient-active.png', width: 35,height: 35) : Image.asset('assets/images/impclient.png', width: 35,height: 35),
                        ),
                        InkWell(
                          onTap: () {
                            final Uri toLaunch =
                            Uri(scheme: 'https', host: 'www.truecaller.com', path: 'search/in/${result[index].mobile}');
                            openTrueCaller(toLaunch);
                          },
                          child: Image.asset(
                            'assets/images/true_caller.png',
                            width: 35,
                            height: 35,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final queryParameters = {
                              'q': '${result[index].mobile}'
                            };
                            final Uri toLaunchUrl =
                            Uri(
                                scheme: 'https',
                                host: 'www.google.co.in',
                                queryParameters: queryParameters,
                                path: 'search');
                            openGoogleSearch(toLaunchUrl);
                          },
                          child: Image.asset(
                            'assets/images/google.png',
                            width: 35,
                            height: 35,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => WhatsappChat(leadId: result[index].leadId, userName: result[index].cname, leadStatus: result[index].lQuality),
                            ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/whatsapp.png',
                            width: 35,
                            height: 35,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }


  void fetchNextPage() {
    scrollController.addListener(() async {
      if(loading) return;
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        getEnqData(userToken, userId, page);
        setState(() {
          loading = true;
        });
      }
    });
  }

  // void getEnqData(userToken, userId, paraPage) async {
  //   // print(paraPage);
  //   var headersData = {
  //     "Content-type": "application/json",
  //     "Authorization": "Bearer $userToken"
  //   };
  //   var response = await http.get(
  //       Uri.parse(
  //           '$apiRootUrl/all_statusunkn.php?user_id=$userId&page_no=$page'),
  //       headers: headersData);
  //   EnquiryModal enquiryModal = EnquiryModal.fromJson(json.decode(response.body));
  //   result = result + enquiryModal.enqlist!;
  //   int localPage = page + 1;
  //   setState(() {
  //     loading = false;
  //     result;
  //     page = localPage;
  //   });
  // }

  Future getEnqData(userToken, userId, paraPage) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/all_statusunkn.php';
    var url = Uri.parse(apiUrl);

    var data = {
      "user_id": userId,
      "page_no": page,
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
    EnquiryModal enquiryModal = EnquiryModal.fromJson(json.decode(response.body));
    result = result + enquiryModal.enqlist!;
    int localPage = page + 1;
    setState(() {
      result;
      loading = false;
      page = localPage;
    });
  }

  void getCLI(userId, userToken) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(Uri.parse('$apiRootUrl/cli_number.php?user_id=$userId'), headers: headersData);
    CliModal cliModalClass = CliModal.fromJson(json.decode(response.body));
    clinumber = clinumber + cliModalClass.clilist!;
    setState(() {
      clinumber;
    });
  }

  Widget cliSheet(destMobile, leadId) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height: 15,),
      Text('Choose one of the below', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
      SizedBox(height: 15,),
      Container(
        width: 230,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: clinumber.length,
          itemBuilder: (context, index) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                minimumSize: Size(250, 40),
              ),
              onPressed: () {
                clickToCall(destMobile, result[index].agentmobile, leadId, clinumber[index].clinumber);
                Navigator.pop(context);
              },
              child: Text('${clinumber[index].clinumber}', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
            );
          },
        ),
      ),

      SizedBox(height: 20.0,),

      ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: Text('Close', style: TextStyle(color: Colors.white, fontSize: 20.0),),
      ),
      SizedBox(height: 20.0,),
    ],
  );

  void clickToCall(custNumber, agentMobile, leadId, callerId) async {
    Fluttertoast.showToast(
        msg: 'Connecting...',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20.0
    );

    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    custNumber = stringToBase64.decode(custNumber);
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjE2NTY4NCwiaXNzIjoiaHR0cHM6XC9cL2Nsb3VkcGhvbmUudGF0YXRlbGVzZXJ2aWNlcy5jb21cL3Rva2VuXC9nZW5lcmF0ZSIsImlhdCI6MTYzNzY3NjQwNiwiZXhwIjoxOTM3Njc2NDA2LCJuYmYiOjE2Mzc2NzY0MDYsImp0aSI6InBQbjBtY2tIQmV2OXZQYjYifQ.tTTg5sSeUyE2dGDLRnAUJDGb4pIKBPpDJGWRy7s7UVY",
    };
    var reqParameter = {
      "destination_number": "$custNumber",
      "agent_number": "$agentMobile",
      "caller_id": "$callerId",
      "custom_identifier": "$leadId"
    };
    // print(reqParameter);

    var response = await http.post(Uri.parse('https://api-smartflo.tatateleservices.com/v1/click_to_call'), headers: headersData, body: jsonEncode(reqParameter));
    // print(response.body);
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StatusUnknPage(tabIndex: 0)));
  }

  Future<void> openTrueCaller(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }


  Future<void> openGoogleSearch(Uri url) async {
    print(url);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }



}
