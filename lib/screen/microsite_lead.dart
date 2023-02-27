import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../gloabal_variable.dart';
import '../lead_view.dart';
import '../modals/cli_number.dart';
import '../modals/newlead_modal.dart';
import '../user_preference.dart';
import '../whatsapp_chat.dart';

class MicrositeLead extends StatefulWidget {
  final searchDate;
  const MicrositeLead({Key? key, this.searchDate}) : super(key: key);

  @override
  State<MicrositeLead> createState() => _MicrositeLeadState();
}

class _MicrositeLeadState extends State<MicrositeLead> {
  List<Newleadlist> micrositelead = [];
  List<Clilist> clinumber = [];
  ScrollController scrollController = ScrollController();
  bool loading = true;
  int page = 1;
  String? userToken = '';
  String? userId = '';
  TextEditingController leaddate = TextEditingController();
  // String curreDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  void initState() {
    super.initState();
    leaddate.text = widget.searchDate;
    // fetchNextPage();
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    getMicrositeData(userToken, userId, page, leaddate.text);
    // getCLI(userId, userToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(bottom: 50),
          child: _buildBody(),
      ),
    );
  }


  Widget _buildBody() {
    return Column(
      children: [
        // Container(
        //   child: TextField(
        //     readOnly: true,
        //     controller: leaddate,
        //     style: TextStyle(color: Colors.black, fontSize: 16.0,),
        //     decoration: InputDecoration(
        //       suffixIcon: Icon(Icons.calendar_today, color: Colors.orange,),
        //       contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
        //       hintText: 'Search by date',
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.all(Radius.circular(8)),
        //       ),
        //     ),
        //
        //     onTap: () async {
        //       DateTime? pickedDate =  await showDatePicker(
        //           context: context,
        //           initialDate: DateTime.now(),
        //           firstDate: DateTime(1900),
        //           lastDate: DateTime(2100)
        //       );
        //       if(pickedDate != null){
        //         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        //         leaddate.text = formattedDate;
        //         setState(() {
        //           getMicrositeData(userToken, userId, page, leaddate.text);
        //         });
        //       }
        //     },
        //   ),
        // ),

        SizedBox(height: 5,),

        Expanded(
            child: micrositelead.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: micrositelead.length,
                itemBuilder: (context, index){
                  if(micrositelead[index].leadId!.isNotEmpty){
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(right: 5, left: 5),
                        title: Text(
                          '${micrositelead[index].cname}  (${micrositelead[index].leadId})',
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${micrositelead[index].nomasked}', style: TextStyle(color: Colors.black),),
                            Text(
                              '${micrositelead[index].agent}  ${micrositelead[index].leadQuality}',
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
                                      addFavorite(micrositelead[index].leadId, userToken);
                                    },
                                    child: micrositelead[index].favorite == '0' ? Icon(Icons.favorite, color: Colors.grey) : Icon(Icons.favorite, color: Colors.red),
                                  ),
                                  SizedBox(width: 10,),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context, MaterialPageRoute(
                                          builder: (context) => LeadView(leadId: micrositelead[index].leadId),
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
                                          builder: (context) => WhatsappChat(leadId: micrositelead[index].leadId, userName: micrositelead[index].cname, leadStatus: micrositelead[index].leadQuality),
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


  void getMicrositeData(userToken, userId, paraPage, planDate) async {
    micrositelead.clear();
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/microsite_lead.php?user_id=$userId&page_no=$page&plan_date=$planDate'),
        headers: headersData);
    // print(response.body);
    NewleadModal newleadModal = NewleadModal.fromJson(json.decode(response.body));
    micrositelead = micrositelead + newleadModal.newleadlist!;
    // print(result);
    // int localPage = page + 1;
    setState(() {
      micrositelead;
      loading = false;
      // page = localPage;
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
    getMicrositeData(userToken, userId, page, leaddate.text);
  }

}
