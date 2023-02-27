import 'dart:convert';

import 'package:crm_software/gloabal_variable.dart';
import 'package:crm_software/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'modals/leadupdate_modal.dart';

class AddComment extends StatefulWidget {
  final leadId;
  const AddComment({Key? key, this.leadId}) : super(key: key);

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? userToken = '';
  String? userId = '';
  TextEditingController comLeadId = TextEditingController();
  TextEditingController comLeadName = TextEditingController();
  TextEditingController comment = TextEditingController();
  List<Leadupdatepop> updateleaddata = [];
  bool _isButtonDisabled = false;

  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    comLeadId.text = widget.leadId;
    getComData(userToken, widget.leadId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: _scaffoldkey,
        body: Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: updateleaddata.isEmpty ? Center(child: CircularProgressIndicator()) : Column(
              children: [
                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: comLeadId,
                        style: TextStyle(color: Colors.black, fontSize: 16.0,),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          labelText: 'Lead Id',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextFormField(
                        controller: comLeadName,
                        style: TextStyle(color: Colors.black, fontSize: 16.0,),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
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
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please Enter Comment';
                            }else{
                              return null;
                            }
                          }
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          _isButtonDisabled ? null : updateComment(userToken, userId, widget.leadId);
                        }
                      },
                      child: Text('SUBMIT', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getComData(userToken, leadId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/lead_update.php?lead_id=$leadId'),
        headers: headersData);
    // print(response.body);
    UpdateLead leadUpdateData = UpdateLead.fromJson(jsonDecode(response.body));
    updateleaddata = updateleaddata + leadUpdateData.leadupdatepop!;
    if(updateleaddata.isNotEmpty){
      setState(() {
        comLeadName.text = updateleaddata[0].custName!;
        comment.text = updateleaddata[0].comment!;
      });

    }
  }


  Future<void> updateComment(userToken, userId, leadId) async {
    setState(() {
      _isButtonDisabled = true;
    });
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/qualified_update.php';
    var url = Uri.parse(apiUrl);
    var data = {
      "lead_id": leadId,
      "user_id": userId,
      "cust_name": comLeadName.text,
      "qual_comment": comment.text,
    };
    var request = jsonEncode(data);

    Response response = await http.post(
        url,
        body: request,
        headers: headersData
    );

    if (response.statusCode == 200) {
      var responseArr = jsonDecode(response.body);
      if(responseArr['rstatus'] == '1'){
        Fluttertoast.showToast(
            msg: 'Comment Added Successfully',
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

    setState(() {
      _isButtonDisabled = false;
    });

  }


}
