import 'dart:convert';
import 'dart:io';
import 'package:crm_software/gloabal_variable.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../modals/focusedproject_modal.dart';
import '../modals/project_modal.dart';
import '../modals/whtamplate_modal.dart';
import '../user_preference.dart';

class WhatsappAttachment extends StatefulWidget {
  final leadId;
  const WhatsappAttachment({Key? key, this.leadId}) : super(key: key);

  @override
  State<WhatsappAttachment> createState() => _WhatsappAttachmentState();
}

class _WhatsappAttachmentState extends State<WhatsappAttachment> {
  List<Tamplatelist> whatsapptamplates = [];
  List<Focusedproject> focusedprojects = [];
  List<File> _attachedFiles = [];
  List<Projectlist> projects = [];
  Dio dio = Dio();
  FilePickerResult? result;
  String? userToken = '';
  String? userId = '';
  bool flileLoader = false;
  TextEditingController prefProject1 = TextEditingController();

  static String _displayStringForOption(Projectlist option) => option.projectname!;

  @override
  void initState() {
    userToken = UserPreference.getUserToken() ?? '';
    userId = UserPreference.getUserId() ?? '';
    getWhatsappTamplate(userToken, userId, widget.leadId);
    getFocusedProject(userToken, userId, widget.leadId);
    getProjectList(userToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: MediaQuery.of(context).size.height * 0.85,
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Center(child: Text('Send Template / Files On Whatsapp', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),)),
            SizedBox(height: 10,),
            Center(child: Text('Whatsapp Tamplate', style: TextStyle(fontSize: 14, color: Colors.blue),)),
            SizedBox(height: 10,),
            bodySectionTemplate(),
            SizedBox(height: 10,),
            Center(child: Text('Attach File', style: TextStyle(fontSize: 14, color: Colors.blue),)),
            SizedBox(height: 2,),
            filePickerSection(),
            SizedBox(height: 10,),
            Center(child: Text('Search Project', style: TextStyle(fontSize: 14, color: Colors.blue),)),
            SizedBox(height: 2,),
            searchProject(),
            SizedBox(height: 10,),
            Center(child: Text('Send Business Card', style: TextStyle(fontSize: 14, color: Colors.blue),)),
            SizedBox(height: 5,),
            sendVisitingSection(),
            SizedBox(height: 10,),
            Center(child: Text('Focused Projects', style: TextStyle(fontSize: 14, color: Colors.blue),)),
            SizedBox(height: 2,),
            sendAttachmentSection(),
          ],
        ),
      ),
    );
  }



  Container bodySectionTemplate() {
    return Container(
      child: whatsapptamplates.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
            itemCount: whatsapptamplates.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: InkWell(
                    onTap: () {
                      sendTamplate(userToken, userId, whatsapptamplates[index].wptamplateid, widget.leadId);
                    },
                    child: Text('${whatsapptamplates[index].wptamplate}', style: TextStyle(fontSize: 16),),
                  ),
                ),
              );
            }
        ),
    );
  }


  Container filePickerSection() {
    return Container(
      width: double.maxFinite,
      // height: 100,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.green),
        borderRadius: BorderRadius.circular(5),
      ),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      result = await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'mp3', 'mp4'],
                      );
                      if(result != null){
                        _attachedFiles = result!.paths.map((path) => File(path!)).toList();
                        // result!.files.forEach((element) {
                        // });
                      }else{
                        Text('User Not Pick The Any File');
                      }
                    },
                    child: Text('Choose File'),
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                    onPressed: () {
                      uploadAttachment(userToken, userId, widget.leadId);
                    },
                    child: Text('Send'),
                ),
                SizedBox(width: 10,),
                Visibility(
                  maintainState: true,
                  visible: flileLoader,
                  child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                ),
              ],
            ),

            SizedBox(height: 5,),

            result != null ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: result?.files.length ?? 0,
              itemBuilder: (context, index) {
                return Text(result?.files[index].name ?? '');
              },
            ) : SizedBox(height: 0,),
          ],
        ),
      ),
    );
  }


  Container searchProject() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 50,
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
                    hintText: 'Search Project',
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
                  alignment: Alignment.topCenter,
                  child: Material(
                    color: Colors.grey,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.99,
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
                print(selection.projectname);
                {FocusManager.instance.primaryFocus?.unfocus();}
                sendAttachmentSearch(userToken, userId, widget.leadId, selection.projectname);
              },
            ),
          ),
        ],
      ),
    );
  }


  Container sendAttachmentSection() {
    return Container(
      color: Colors.grey.shade300,
      height: 400,
      child: focusedprojects.isEmpty ? Center(child: CircularProgressIndicator()) : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 3/2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          itemCount: focusedprojects.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    sendAttachment(userToken, userId, widget.leadId, focusedprojects[index].projfolder);
                  },
                  child: Image.network('$rootUrl/img/top-project/${focusedprojects[index].logoimage}'),
                ),
              ),
            );
          }
      ),
    );
  }


  Container sendVisitingSection() {
    return Container(
      height: 50,
      child: InkWell(
        onTap: () {
          sendAttachment(userToken, userId, widget.leadId, 'visiting');
        },
          child: Image.network('$rootUrl/visiting/$userId/$userId.jpg'),
      ),
    );
  }


  void getWhatsappTamplate(userToken, userId, leadId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/whatsapp_tamplate.php?user_id=$userId&lead_id=$leadId'),
        headers: headersData);
    WhatsappTamplate tamplateModal = WhatsappTamplate.fromJson(json.decode(response.body));
    whatsapptamplates = whatsapptamplates + tamplateModal.tamplatelist!;
    setState(() {
      whatsapptamplates;
    });
  }

  void getFocusedProject(userToken, userId, leadId) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/focused_project.php?user_id=$userId&lead_id=$leadId'),
        headers: headersData);
    FocucedProject focucedProject = FocucedProject.fromJson(json.decode(response.body));
    focusedprojects = focusedprojects + focucedProject.focusedproject!;
    setState(() {
      focusedprojects;
    });
  }

  void getProjectList(userToken) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            '$apiRootUrl/search_project.php'),
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



  Future<void> sendTamplate(userToken, userId, templateId, leadId) async {
    AlertDialog alertDialog = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
          return alertDialog;
        },
    );
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/send_tamplate.php';
    var url = Uri.parse(apiUrl);
    var data = {
      "lead_id": leadId,
      "user_id": userId,
      "template_id": templateId,
    };
    var request = jsonEncode(data);

    http.Response response = await http.post(
        url,
        body: request,
        headers: headersData
    );

    Navigator.pop(context);

    if (response.statusCode == 200) {
      var responseArr = jsonDecode(response.body);
      if(responseArr['status'] == '1'){
        Fluttertoast.showToast(
            msg: 'Detail has been sent',
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


  Future<void> sendAttachment(userToken, userId, leadId, projectFolder) async {
    AlertDialog alertDialog = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/send_attachment.php';
    var url = Uri.parse(apiUrl);
    var data = {
      "lead_id": leadId,
      "user_id": userId,
      "project_folder": projectFolder,
    };
    var request = jsonEncode(data);

    http.Response response = await http.post(
        url,
        body: request,
        headers: headersData
    );

    Navigator.pop(context);

    if (response.statusCode == 200) {
      var responseArr = jsonDecode(response.body);
      if(responseArr['status'] == '1'){
        Fluttertoast.showToast(
            msg: 'Details has been sent',
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


  Future<void> sendAttachmentSearch(userToken, userId, leadId, projectName) async {
    AlertDialog alertDialog = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var apiUrl = '$apiRootUrl/send_searchattachment.php';
    var url = Uri.parse(apiUrl);
    var data = {
      "lead_id": leadId,
      "user_id": userId,
      "project_name": projectName,
    };
    var request = jsonEncode(data);

    http.Response response = await http.post(
        url,
        body: request,
        headers: headersData
    );

    Navigator.pop(context);

    if (response.statusCode == 200) {
      var responseArr = jsonDecode(response.body);
      if(responseArr['status'] == '1'){
        Fluttertoast.showToast(
            msg: 'Details has been sent',
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


  uploadAttachment(String? userToken, String? userId, leadId) async {
    setState(() {
      flileLoader = true;
    });
    FormData formData = FormData.fromMap({
    'lead_id': leadId,
    'user_id': userId
    });

    if(_attachedFiles != null) {
      for(var file in _attachedFiles) {
        formData.files.addAll([MapEntry('_attachedFiles[]', await MultipartFile.fromFile(file.path))]);
      }
      dio.options.connectTimeout = 20000;
      Response response;

      var apiUrl = '$apiRootUrl/upload_attachment.php';
      var url = Uri.parse(apiUrl);
      response = await dio.post(
        apiUrl,
        options: Options(
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer $userToken"
          }),
        data: formData,
      );
      if(response.statusCode == 200){
        setState(() {
          flileLoader = false;
        });
        var responseArr = response.data;
        if(responseArr['status'] == '1'){
          Fluttertoast.showToast(
              msg: 'Details has been sent',
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
        setState(() {
          flileLoader = false;
        });
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


}
