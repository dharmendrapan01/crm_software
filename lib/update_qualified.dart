import 'dart:convert';
import 'package:crm_software/modals/leadupdate_modal.dart';
import 'package:crm_software/modals/project_modal.dart';
import 'package:crm_software/user_preference.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateQualified extends StatefulWidget {
  final leadId;
  const UpdateQualified({Key? key, this.leadId}) : super(key: key);

  @override
  State<UpdateQualified> createState() => _UpdateQualifiedState();
}

class _UpdateQualifiedState extends State<UpdateQualified> {
  final formKey = GlobalKey<FormState>();
  TextEditingController qualLeadId = TextEditingController();
  TextEditingController qualLeadName = TextEditingController();
  TextEditingController prefProject1 = TextEditingController();
  TextEditingController prefProject2 = TextEditingController();
  TextEditingController prefocation1 = TextEditingController();
  TextEditingController prefocation2 = TextEditingController();
  TextEditingController comment = TextEditingController();

  List<Leadupdatepop> updateleaddata = [];
  List<Projectlist> projects = [];

  String? userToken = '';
  String? userId = '';
  String quality = '1';
  String qualifiedType = '1';
  String propertyType = 'residential';
  String closerPipLine = 'yes';
  String piplineStatus = '';
  String verCloser = '';
  String hot = '1';
  String strongFollup = 'yes';

  String minBudgetc = '0';
  List minBudgetData = [
    {"title": "0 Cr", "value": "0"},{"title": "1 Cr", "value": "1"},{"title": "2 Cr", "value": "2"},{"title": "3 Cr", "value": "3"},{"title": "4 Cr", "value": "4"},{"title": "5 Cr", "value": "5"},{"title": "6 Cr", "value": "6"},{"title": "7 Cr", "value": "7"},{"title": "8 Cr", "value": "8"},{"title": "9 Cr", "value": "9"},{"title": "10 Cr", "value": "10"},{"title": "11 Cr", "value": "11"},{"title": "12 Cr", "value": "12"},{"title": "13 Cr", "value": "13"},{"title": "14 Cr", "value": "14"},{"title": "15 Cr", "value": "15"},{"title": "16 Cr", "value": "16"},{"title": "17 Cr", "value": "17"},{"title": "18 Cr", "value": "18"},{"title": "19 Cr", "value": "19"},{"title": "20 Cr", "value": "20"},{"title": "21 Cr", "value": "21"},{"title": "22 Cr", "value": "22"},{"title": "23 Cr", "value": "23"},{"title": "24 Cr", "value": "24"},{"title": "25 Cr", "value": "25"},
  ];

  String minBudgetL = '0';
  List minBudgetDataL = [
    {"title": "0 L", "value": "0"},{"title": "1 L", "value": "1"},{"title": "2 L", "value": "2"},{"title": "3 L", "value": "3"},{"title": "4 L", "value": "4"},{"title": "5 L", "value": "5"},{"title": "6 L", "value": "6"},{"title": "7 L", "value": "7"},{"title": "8 L", "value": "8"},{"title": "9 L", "value": "9"},{"title": "10 L", "value": "10"},{"title": "11 L", "value": "11"},{"title": "12 L", "value": "12"},{"title": "13 L", "value": "13"},{"title": "14 L", "value": "14"},{"title": "15 L", "value": "15"},{"title": "16 L", "value": "16"},{"title": "17 L", "value": "17"},{"title": "18 L", "value": "18"},{"title": "19 L", "value": "19"},{"title": "20 L", "value": "20"},{"title": "21 L", "value": "21"},{"title": "22 L", "value": "22"},{"title": "23 L", "value": "23"},{"title": "24 L", "value": "24"},{"title": "25 L", "value": "25"},{"title": "26 L", "value": "26"},{"title": "27 L", "value": "27"},{"title": "28 L", "value": "28"},{"title": "29 L", "value": "29"},{"title": "30 L", "value": "30"},{"title": "31 L", "value": "31"},{"title": "32 L", "value": "32"},{"title": "33 L", "value": "33"},{"title": "34 L", "value": "34"},{"title": "35 L", "value": "35"},{"title": "36 L", "value": "36"},{"title": "37 L", "value": "37"},{"title": "38 L", "value": "38"},{"title": "39 L", "value": "39"},{"title": "40 L", "value": "40"},{"title": "41 L", "value": "41"},{"title": "42 L", "value": "42"},{"title": "43 L", "value": "43"},{"title": "44 L", "value": "44"},{"title": "45 L", "value": "45"},{"title": "46 L", "value": "46"},{"title": "47 L", "value": "47"},{"title": "48 L", "value": "48"},{"title": "49 L", "value": "49"},{"title": "50 L", "value": "50"},{"title": "51 L", "value": "51"},{"title": "52 L", "value": "52"},{"title": "53 L", "value": "53"},{"title": "54 L", "value": "54"},{"title": "55 L", "value": "55"},{"title": "56 L", "value": "56"},{"title": "57 L", "value": "57"},{"title": "58 L", "value": "58"},{"title": "59 L", "value": "59"},{"title": "60 L", "value": "60"},{"title": "61 L", "value": "61"},{"title": "62 L", "value": "62"},{"title": "63 L", "value": "63"},{"title": "64 L", "value": "64"},{"title": "65 L", "value": "65"},{"title": "66 L", "value": "66"},{"title": "67 L", "value": "67"},{"title": "68 L", "value": "68"},{"title": "69 L", "value": "69"},{"title": "70 L", "value": "70"},{"title": "71 L", "value": "71"},{"title": "72 L", "value": "72"},{"title": "73 L", "value": "73"},{"title": "74 L", "value": "74"},{"title": "75 L", "value": "75"},{"title": "76 L", "value": "76"},{"title": "77 L", "value": "77"},{"title": "78 L", "value": "78"},{"title": "79 L", "value": "79"},{"title": "80 L", "value": "80"},{"title": "81 L", "value": "81"},{"title": "82 L", "value": "82"},{"title": "83 L", "value": "83"},{"title": "84 L", "value": "84"},{"title": "85 L", "value": "85"},{"title": "86 L", "value": "86"},{"title": "87 L", "value": "87"},{"title": "88 L", "value": "88"},{"title": "89 L", "value": "89"},{"title": "90 L", "value": "90"},{"title": "91 L", "value": "91"},{"title": "92 L", "value": "92"},{"title": "93 L", "value": "93"},{"title": "94 L", "value": "94"},{"title": "95 L", "value": "95"},{"title": "96 L", "value": "96"},{"title": "97 L", "value": "97"},{"title": "98 L", "value": "98"},{"title": "99 L", "value": "99"}
  ];

  String maxBudgetc = '0';
  List maxBudgetData = [
    {"title": "0 Cr", "value": "0"},{"title": "1 Cr", "value": "1"},{"title": "2 Cr", "value": "2"},{"title": "3 Cr", "value": "3"},{"title": "4 Cr", "value": "4"},{"title": "5 Cr", "value": "5"},{"title": "6 Cr", "value": "6"},{"title": "7 Cr", "value": "7"},{"title": "8 Cr", "value": "8"},{"title": "9 Cr", "value": "9"},{"title": "10 Cr", "value": "10"},{"title": "11 Cr", "value": "11"},{"title": "12 Cr", "value": "12"},{"title": "13 Cr", "value": "13"},{"title": "14 Cr", "value": "14"},{"title": "15 Cr", "value": "15"},{"title": "16 Cr", "value": "16"},{"title": "17 Cr", "value": "17"},{"title": "18 Cr", "value": "18"},{"title": "19 Cr", "value": "19"},{"title": "20 Cr", "value": "20"},{"title": "21 Cr", "value": "21"},{"title": "22 Cr", "value": "22"},{"title": "23 Cr", "value": "23"},{"title": "24 Cr", "value": "24"},{"title": "25 Cr", "value": "25"},
  ];

  String maxBudgetL = '0';
  List maxBudgetDataL = [
    {"title": "0 L", "value": "0"},{"title": "1 L", "value": "1"},{"title": "2 L", "value": "2"},{"title": "3 L", "value": "3"},{"title": "4 L", "value": "4"},{"title": "5 L", "value": "5"},{"title": "6 L", "value": "6"},{"title": "7 L", "value": "7"},{"title": "8 L", "value": "8"},{"title": "9 L", "value": "9"},{"title": "10 L", "value": "10"},{"title": "11 L", "value": "11"},{"title": "12 L", "value": "12"},{"title": "13 L", "value": "13"},{"title": "14 L", "value": "14"},{"title": "15 L", "value": "15"},{"title": "16 L", "value": "16"},{"title": "17 L", "value": "17"},{"title": "18 L", "value": "18"},{"title": "19 L", "value": "19"},{"title": "20 L", "value": "20"},{"title": "21 L", "value": "21"},{"title": "22 L", "value": "22"},{"title": "23 L", "value": "23"},{"title": "24 L", "value": "24"},{"title": "25 L", "value": "25"},{"title": "26 L", "value": "26"},{"title": "27 L", "value": "27"},{"title": "28 L", "value": "28"},{"title": "29 L", "value": "29"},{"title": "30 L", "value": "30"},{"title": "31 L", "value": "31"},{"title": "32 L", "value": "32"},{"title": "33 L", "value": "33"},{"title": "34 L", "value": "34"},{"title": "35 L", "value": "35"},{"title": "36 L", "value": "36"},{"title": "37 L", "value": "37"},{"title": "38 L", "value": "38"},{"title": "39 L", "value": "39"},{"title": "40 L", "value": "40"},{"title": "41 L", "value": "41"},{"title": "42 L", "value": "42"},{"title": "43 L", "value": "43"},{"title": "44 L", "value": "44"},{"title": "45 L", "value": "45"},{"title": "46 L", "value": "46"},{"title": "47 L", "value": "47"},{"title": "48 L", "value": "48"},{"title": "49 L", "value": "49"},{"title": "50 L", "value": "50"},{"title": "51 L", "value": "51"},{"title": "52 L", "value": "52"},{"title": "53 L", "value": "53"},{"title": "54 L", "value": "54"},{"title": "55 L", "value": "55"},{"title": "56 L", "value": "56"},{"title": "57 L", "value": "57"},{"title": "58 L", "value": "58"},{"title": "59 L", "value": "59"},{"title": "60 L", "value": "60"},{"title": "61 L", "value": "61"},{"title": "62 L", "value": "62"},{"title": "63 L", "value": "63"},{"title": "64 L", "value": "64"},{"title": "65 L", "value": "65"},{"title": "66 L", "value": "66"},{"title": "67 L", "value": "67"},{"title": "68 L", "value": "68"},{"title": "69 L", "value": "69"},{"title": "70 L", "value": "70"},{"title": "71 L", "value": "71"},{"title": "72 L", "value": "72"},{"title": "73 L", "value": "73"},{"title": "74 L", "value": "74"},{"title": "75 L", "value": "75"},{"title": "76 L", "value": "76"},{"title": "77 L", "value": "77"},{"title": "78 L", "value": "78"},{"title": "79 L", "value": "79"},{"title": "80 L", "value": "80"},{"title": "81 L", "value": "81"},{"title": "82 L", "value": "82"},{"title": "83 L", "value": "83"},{"title": "84 L", "value": "84"},{"title": "85 L", "value": "85"},{"title": "86 L", "value": "86"},{"title": "87 L", "value": "87"},{"title": "88 L", "value": "88"},{"title": "89 L", "value": "89"},{"title": "90 L", "value": "90"},{"title": "91 L", "value": "91"},{"title": "92 L", "value": "92"},{"title": "93 L", "value": "93"},{"title": "94 L", "value": "94"},{"title": "95 L", "value": "95"},{"title": "96 L", "value": "96"},{"title": "97 L", "value": "97"},{"title": "98 L", "value": "98"},{"title": "99 L", "value": "99"}
  ];

  static String _displayStringForOption(Projectlist option) => option.projectname!;
  // bool _isButtonDisabled = false;


  @override
  void initState() {
    userId = UserPreference.getUserId() ?? '';
    userToken = UserPreference.getUserToken() ?? '';
    qualLeadId.text = widget.leadId;
    getleadUpdate(userToken, widget.leadId);
    getProjectList(userToken);
    // _isButtonDisabled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    child: Scaffold(
      body: Container(
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
                      controller: qualLeadId,
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
                    controller: qualLeadName,
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
                      labelText: 'Quality',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: quality,
                        isDense: true,
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(child: Text("Qualified for focus"), value: "1"),
                          DropdownMenuItem(child: Text("Qualified for non focus"), value: "8"),
                          DropdownMenuItem(child: Text("Qualified for rent"), value: "9"),
                          DropdownMenuItem(child: Text("Qualified for plot"), value: "10"),
                        ],
                        onChanged: (newQuality) => {
                          setState(() {
                            quality = newQuality!;
                            print(quality.toString());
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
                        labelText: 'Qualified Type',
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: qualifiedType,
                        isDense: true,
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(child: Text("First Sale Buyer"), value: "1"),
                          DropdownMenuItem(child: Text("Resale Buyer"), value: "2"),
                          DropdownMenuItem(child: Text("Qualified Seller"), value: "3"),
                          DropdownMenuItem(child: Text("Qualified Broker"), value: "4"),
                          DropdownMenuItem(child: Text("Qualified Lessor"), value: "5"),
                          DropdownMenuItem(child: Text("Qualified Lessee"), value: "6"),
                          DropdownMenuItem(child: Text("Qualified Resale"), value: "7"),
                        ],
                        onChanged: (newQualifiedType) {
                          setState(() {
                            qualifiedType = newQualifiedType!;
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
                      labelText: 'Property Type',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: propertyType,
                        isDense: true,
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(child: Text("Residential"), value: "residential"),
                          DropdownMenuItem(child: Text("Commercial"), value: "commercial"),
                        ],
                        onChanged: (newPropType) => {
                          setState(() {
                            propertyType = newPropType!;
                            print(propertyType.toString());
                          }),
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10,),

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
                      return TextFormField(
                        autocorrect: false,
                        enableSuggestions: false,
                        controller: controller,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          hintText: 'Search Project 1',
                          labelText: 'Preferred Project 1',
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
                                  Projectlist pr = projectsList.elementAt(index);
                                  return InkWell(
                                    onTap: () => onSelect(pr),
                                    child: ListTile(
                                      title: Text(pr.projectname!),
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
                      prefocation1.text = selection.locationname!;
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
                    initialValue: TextEditingValue(text: prefProject2.text),
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
                          hintText: 'Search Project 2',
                          labelText: 'Preferred Project 2',
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
                      prefocation2.text = selection.locationname!;
                    },
                  ),
                ),

                SizedBox(width: 10,),

                Expanded(
                  child: TextFormField(
                    controller: prefocation1,
                    style: TextStyle(color: Colors.black, fontSize: 16.0,),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      labelText: 'Preferred Location 1',
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
                    controller: prefocation2,
                    style: TextStyle(color: Colors.black, fontSize: 16.0,),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      labelText: 'Preferred Location 2',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10,),

                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Min Budget',
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: minBudgetc,
                              isDense: true,
                              isExpanded: true,
                              menuMaxHeight: 300,
                              items: [
                                ...minBudgetData.map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem(
                                      child: Text(e['title']), value: e['value']
                                  );
                                }).toList(),
                              ],
                              onChanged: (newMinBudC) {
                                setState(() {
                                  minBudgetc = newMinBudC!;
                                  print(newMinBudC);
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 5,),

                      Expanded(
                        child: InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: minBudgetL,
                              isDense: true,
                              isExpanded: true,
                              menuMaxHeight: 300,
                              items: [
                                ...minBudgetDataL.map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem(
                                      child: Text(e['title']), value: e['value']
                                  );
                                }).toList(),
                              ],
                              onChanged: (newMinBudL) {
                                setState(() {
                                  minBudgetL = newMinBudL!;
                                  // print(newMinBudC);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),

            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Max Budget',
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: maxBudgetc,
                              isDense: true,
                              isExpanded: true,
                              menuMaxHeight: 300,
                              items: [
                                ...maxBudgetData.map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem(
                                      child: Text(e['title']), value: e['value']
                                  );
                                }).toList(),
                              ],
                              onChanged: (newMaxBudC) {
                                setState(() {
                                  maxBudgetc = newMaxBudC!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 5,),

                      Expanded(
                        child: InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: maxBudgetL,
                              isDense: true,
                              isExpanded: true,
                              menuMaxHeight: 300,
                              items: [
                                ...maxBudgetDataL.map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem(
                                      child: Text(e['title']), value: e['value']
                                  );
                                }).toList(),
                              ],
                              onChanged: (newMaxBudL) {
                                setState(() {
                                  maxBudgetL = newMaxBudL!;
                                  // print(newMinBudC);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 10,),

                Expanded(
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Strong Followup',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: strongFollup,
                        isDense: true,
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(child: Text("--Select--"), value: ""),
                          DropdownMenuItem(child: Text("Yes"), value: "yes"),
                          DropdownMenuItem(child: Text("No"), value: "no"),
                        ],
                        onChanged: (newStrongfoloup) => {
                          setState(() {
                            strongFollup = newStrongfoloup!;
                          }),
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
                    labelText: 'Closure Pipeline',
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: closerPipLine,
                      isDense: true,
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(child: Text("Yes"), value: "yes"),
                        DropdownMenuItem(child: Text("No"), value: "no"),
                      ],
                      onChanged: (newCloserPipLine) => {
                        setState(() {
                          closerPipLine = newCloserPipLine!;
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
                      labelText: 'Pipeline Status',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: piplineStatus,
                        isDense: true,
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(child: Text("Select Pip Status"), value: ""),
                          DropdownMenuItem(child: Text("Yes This Month"), value: "Yes-this month"),
                          DropdownMenuItem(child: Text("Yes Next Month"), value: "Yes-next month"),
                          DropdownMenuItem(child: Text("90 Day"), value: "Yes-90 Day"),
                          DropdownMenuItem(child: Text("No"), value: "No"),
                          DropdownMenuItem(child: Text("Other"), value: "other"),
                        ],
                        onChanged: (newPipLineStatus) => {
                          setState(() {
                            piplineStatus = newPipLineStatus!;
                          }),
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
                      labelText: 'Verge of Closure',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: verCloser,
                        isDense: true,
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(child: Text("--Select--"), value: ""),
                          DropdownMenuItem(child: Text("Yes"), value: "yes"),
                          DropdownMenuItem(child: Text("No"), value: "no"),
                        ],
                        onChanged: (newVergeCloser) => {
                          setState(() {
                            verCloser = newVergeCloser!;
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
                      labelText: 'Hot',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: hot,
                        isDense: true,
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(child: Text("Yes"), value: "1"),
                          DropdownMenuItem(child: Text("No"), value: "2"),
                        ],
                        onChanged: (newHot) => {
                          setState(() {
                            hot = newHot!;
                          }),
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
                    updateQualify(userToken, userId, widget.leadId);
                    // if(formKey.currentState!.validate()){
                    //   updateQualify(userToken, userId, widget.leadId);
                    // }
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
    );
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
    // print(response.body);
    UpdateLead leadUpdateData = UpdateLead.fromJson(jsonDecode(response.body));
    updateleaddata = updateleaddata + leadUpdateData.leadupdatepop!;
    if(updateleaddata.isNotEmpty){
      setState(() {
        qualLeadName.text = updateleaddata[0].custName!;
        prefProject1.text = updateleaddata[0].project!;
        prefProject2.text = updateleaddata[0].qualproject2!;
        prefocation1.text = updateleaddata[0].preflocation1!;
        prefocation2.text = updateleaddata[0].preflocation2!;
        if(updateleaddata[0].qualifyqual == '0'){qualifiedType = '1';}else{qualifiedType = updateleaddata[0].qualifyqual!;}
        if(updateleaddata[0].proptype == ''){propertyType = 'residential';}else{propertyType = updateleaddata[0].proptype!;}
        if(updateleaddata[0].maxbudgetc == ''){maxBudgetc = '0';}else{maxBudgetc = updateleaddata[0].maxbudgetc!;}
        if(updateleaddata[0].maxbudgetl == ''){maxBudgetL = '0';}else{maxBudgetL = updateleaddata[0].maxbudgetl!;}
        if(updateleaddata[0].strongfoloup == ''){strongFollup = 'yes';}else{strongFollup = updateleaddata[0].strongfoloup!;}
        if(updateleaddata[0].closerpip == ''){closerPipLine = 'no';}else{closerPipLine = updateleaddata[0].closerpip!;}
        if(updateleaddata[0].piplinestatus == ''){piplineStatus = '';}else{piplineStatus = updateleaddata[0].piplinestatus!;}
        if(updateleaddata[0].vergecloser == ''){verCloser = '';}else{verCloser = updateleaddata[0].vergecloser!;}
        if(updateleaddata[0].temprature == '0'){hot = '1';}else{hot = updateleaddata[0].temprature!;}
        comment.text = updateleaddata[0].comment!;
      });

    }
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


  Future<void> updateQualify(userToken, userId, leadId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = 'https://spaze-salesapp.com/app/_api/qualified_update.php';
    var url = Uri.parse(apiUrl);
    var data = {
      "lead_id": leadId,
      "user_id": userId,
      "cust_name": qualLeadName.text,
      "qualified_type": qualifiedType,
      "property_type": propertyType,
      "pref_project1": prefProject1.text,
      "pref_project2": prefProject2.text,
      "pref_location1": prefocation1.text,
      "pref_location2": prefocation2.text,
      "min_budgetc": minBudgetc,
      "min_budgetl": minBudgetL,
      "max_budgetc": maxBudgetc,
      "max_budgetl": maxBudgetL,
      "strong_follup": strongFollup,
      "closer_pipLine": closerPipLine,
      "pipline_status": piplineStatus,
      "ver_closer": verCloser,
      "temperature": hot,
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
            msg: 'Lead Qualified Successfully',
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



