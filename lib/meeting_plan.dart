import 'dart:convert';

import 'package:crm_software/user_preference.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'modals/leadupdate_modal.dart';
import 'modals/project_modal.dart';

class MeetingPlan extends StatefulWidget {
  final leadId;
  const MeetingPlan({Key? key,this.leadId}) : super(key: key);

  @override
  State<MeetingPlan> createState() => _MeetingPlanState();
}

class _MeetingPlanState extends State<MeetingPlan> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController prefProject1 = TextEditingController();
  TextEditingController leadIdText = TextEditingController();
  TextEditingController custNameText = TextEditingController();
  TextEditingController comment = TextEditingController();
  TextEditingController meetdatetime = TextEditingController();
  bool _isButtonDisabled = false;
  String curreMeetDateTime = DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now());


  static String _displayStringForOption(Projectlist option) => option.projectname!;
  List<Projectlist> projects = [];
  List<Leadupdatepop> updateleaddata = [];
  String metStatus = 'planned';
  String metType = 'sv';
  String metLocation = 'site';
  String? userToken = '';
  String? userId = '';

  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    leadIdText.text = widget.leadId;
    meetdatetime.text = curreMeetDateTime;
    getProjectList(userToken);
    getleadUpdate(userToken, widget.leadId);
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
            child: updateleaddata.isEmpty ? Center(child: CircularProgressIndicator()) : ListView(
              children: [
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: leadIdText,
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
                        controller: custNameText,
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
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Meeting Status',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: metStatus,
                            isDense: true,
                            isExpanded: true,
                            items: [
                              DropdownMenuItem(child: Text("Planned"), value: "planned"),
                            ],
                            onChanged: (newMetStatus) => {
                              setState(() {
                                metStatus = newMetStatus!;
                                // print(quality.toString());
                              }),
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10,),

                    Expanded(
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Meeting Type',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: metType,
                            isDense: true,
                            isExpanded: true,
                            items: [
                              DropdownMenuItem(child: Text("1st Meeting"), value: "f2f"),
                              DropdownMenuItem(child: Text("1st Site Visit"), value: "sv"),
                              DropdownMenuItem(child: Text("FUP Site Visit"), value: "fsv"),
                              DropdownMenuItem(child: Text("FUP Meeting"), value: "followup"),
                              DropdownMenuItem(child: Text("Closer Meeting"), value: "closer"),
                              DropdownMenuItem(child: Text("Service Meeting"), value: "service"),
                              DropdownMenuItem(child: Text("Internal Meeting"), value: "none"),
                            ],
                            onChanged: (newMetType) {
                              setState(() {
                                metType = newMetType!;
                                // print(qualifiedType.toString());
                              });
                            },
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
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Meeting Location',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: metLocation,
                            isDense: true,
                            isExpanded: true,
                            items: [
                              DropdownMenuItem(child: Text("Site"), value: "site"),
                              DropdownMenuItem(child: Text("Residence"), value: "residence"),
                              DropdownMenuItem(child: Text("Office"), value: "office"),
                              DropdownMenuItem(child: Text("Other"), value: "other"),
                              DropdownMenuItem(child: Text("None"), value: "none"),
                            ],
                            onChanged: (newMetLoc) => {
                              setState(() {
                                metLocation = newMetLoc!;
                                // print(quality.toString());
                              }),
                            },
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10,),

                    Expanded(
                        child: TextField(
                          readOnly: true,
                          controller: meetdatetime,
                          style: TextStyle(color: Colors.black, fontSize: 16.0,),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.calendar_today, color: Colors.orange,),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            labelText: 'Meeting Date',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),

                          onTap: () async {
                            DateTime? pickedDate =  await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100)
                            );
                            if(pickedDate != null){
                              TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                              );
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              if(pickedTime != null ){
                                // print(pickedTime.format(context));   //output 10:51 PM
                                DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTimeField.combine(pickedDate, pickedTime));
                                setState(() {
                                  meetdatetime.text = formattedDateTime;
                                });
                              }
                            }
                          },
                        ),
                    ),
                  ],
                ),

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Autocomplete<Projectlist>(
                        initialValue: TextEditingValue(text: prefProject1.text),
                        displayStringForOption: _displayStringForOption,
                        optionsBuilder: (TextEditingValue textEditingValue){
                          if(textEditingValue.text == ''){
                            return const Iterable<Projectlist>.empty();
                          }else{
                            return projects.where((element){
                              return element.projectname.toString().toLowerCase()
                                  .contains(textEditingValue.text.toLowerCase());
                            }).toList();
                          }
                        },
                        fieldViewBuilder: (
                            BuildContext context,
                            TextEditingController controller,
                            focusNode, node
                            ){
                          return TextField(
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: controller,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              hintText: 'Search Project',
                              labelText: 'Meeting Project',
                              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          );
                        },
                        optionsViewBuilder: (
                            BuildContext context,
                            Function onSelect,
                            Iterable<Projectlist> projectsList,
                            ){
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              color: Colors.grey,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 220,
                                constraints: BoxConstraints(
                                  maxHeight: MediaQuery.of(context).size.height * 0.40,
                                ),
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: projectsList.length,
                                    separatorBuilder: (context, i){
                                      return Divider(
                                        color: Colors.white,
                                        height: 1,
                                        thickness: 2,
                                      );
                                    },
                                    itemBuilder: (context, index){
                                      Projectlist p = projectsList.elementAt(index);
                                      return InkWell(
                                        onTap: () => onSelect(p),
                                        child: ListTile(
                                          title: Text(p.projectname!),
                                        ),
                                      );
                                    }
                                ),
                              ),
                            ),
                          );
                        },
                        onSelected: (selection){
                          {FocusManager.instance.primaryFocus?.unfocus();}
                        },
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
                          _isButtonDisabled ? null : updateMeeting(userToken, userId, widget.leadId);
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

  void getProjectList(userToken) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            'https://spaze-salesapp.com/app/_api/search_project.php'),
        headers: headersData);
    // print(response.body);
    ProjectListModal projectListModal = ProjectListModal.fromJson(jsonDecode(response.body));
    projects = projects + projectListModal.projectlist!;
    setState(() {
      // print(projects);
      projects;
      // projectModal = ProjectListModal.fromJson(jsonDecode(response.body));
    });
  }


  void getleadUpdate(userToken, leadId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            'https://spaze-salesapp.com/app/_api/lead_update.php?lead_id=$leadId'),
        headers: headersData);
    UpdateLead leadUpdateData = UpdateLead.fromJson(jsonDecode(response.body));
    updateleaddata = updateleaddata + leadUpdateData.leadupdatepop!;
    if(updateleaddata.isNotEmpty){
      setState(() {
        custNameText.text = updateleaddata[0].custName!;
        prefProject1.text = updateleaddata[0].project!;
        comment.text = updateleaddata[0].comment!;
      });

    }
  }


  Future<void> updateMeeting(userToken, userId, leadId) async {
    setState(() {
      _isButtonDisabled = true;
    });
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = 'https://spaze-salesapp.com/app/_api/add_meeting.php';
    var url = Uri.parse(apiUrl);
    var data = {
      "lead_id": leadId,
      "user_id": userId,
      "cust_name": custNameText.text,
      "meet_status": metStatus,
      "meet_type": metType,
      "meet_location": metLocation,
      "meet_date": meetdatetime.text,
      "meet_project": prefProject1.text,
      "meet_comment": comment.text,
    };
    // print(data);
    var request = jsonEncode(data);

    Response response = await http.post(
        url,
        body: request,
        headers: headersData
    );
    // print(response);

    if (response.statusCode == 200) {
      var responseArr = jsonDecode(response.body);
      if(responseArr['rstatus'] == '1'){
        Fluttertoast.showToast(
            msg: 'Meeting Plan Successfully',
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
