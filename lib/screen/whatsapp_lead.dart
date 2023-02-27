import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../gloabal_variable.dart';
import '../lead_view.dart';
import '../modals/newlead_modal.dart';
import '../user_preference.dart';
import '../whatsapp_chat.dart';

class WhatsappLead extends StatefulWidget {
  final searchDate;
  const WhatsappLead({Key? key, this.searchDate}) : super(key: key);

  @override
  State<WhatsappLead> createState() => _WhatsappLeadState();
}

class _WhatsappLeadState extends State<WhatsappLead> {
  List<Newleadlist> dataresult = [];
  int page = 1;
  String? userToken = '';
  String? userId = '';
  TextEditingController searchdateval = TextEditingController();
  // String curreDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  void initState() {
    super.initState();
    searchdateval.text = widget.searchDate;
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    getWhatsappData(userToken, userId, page, searchdateval.text);
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
        //     controller: searchdateval,
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
        //         searchdateval.text = formattedDate;
        //         setState(() {
        //           getWhatsappData(userToken, userId, page, searchdateval.text);
        //         });
        //       }
        //     },
        //   ),
        // ),

        SizedBox(height: 5,),

        Expanded(
          child: dataresult.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: dataresult.length,
              itemBuilder: (context, index){
                if(dataresult[index].leadId!.isNotEmpty){
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(right: 5, left: 5),
                      title: Text(
                        '${dataresult[index].cname}  (${dataresult[index].leadId})',
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${dataresult[index].nomasked}', style: TextStyle(color: Colors.black),),
                          Text(
                            '${dataresult[index].agent}  ${dataresult[index].leadQuality}',
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
                                    addFavorite(dataresult[index].leadId, userToken);
                                  },
                                  child: dataresult[index].favorite == '0' ? Icon(Icons.favorite, color: Colors.grey) : Icon(Icons.favorite, color: Colors.red),
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (context) => LeadView(leadId: dataresult[index].leadId),
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
                                        builder: (context) => WhatsappChat(leadId: dataresult[index].leadId, userName: dataresult[index].cname, leadStatus: dataresult[index].leadQuality),
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

  void getWhatsappData(userToken, userId, paraPage, searchDate) async {
    dataresult.clear();
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/whatsapp_lead.php?user_id=$userId&page_no=$page&search_date=$searchDate'),
        headers: headersData);
    NewleadModal newleadModal = NewleadModal.fromJson(json.decode(response.body));
    dataresult = dataresult + newleadModal.newleadlist!;
    setState(() {
      dataresult;
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
    getWhatsappData(userToken, userId, page, searchdateval.text);
  }

}
