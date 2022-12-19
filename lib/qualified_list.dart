import 'dart:convert';

import 'package:crm_software/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'callhistory_modal.dart';

class QualifiedList extends StatefulWidget {
  const QualifiedList({Key? key}) : super(key: key);

  @override
  State<QualifiedList> createState() => _QualifiedListState();
}

class _QualifiedListState extends State<QualifiedList> {
  List<Datalist> result = [];
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
    setState(() {
      getData(userToken, userId, page);
    });
  }

  void getData(userToken, userId, paraPage) async {
    var headersData = {
      "Content-type": "application/json",
      "Authorization": "Bearer $userToken"
    };
    var response = await http.get(
        Uri.parse(
            'https://spaze-salesapp.com/app/_api/callhistory.php?user_id=$userId&page_no=$page'),
        headers: headersData);
    User userClass = User.fromJson(json.decode(response.body));
    result = result + userClass.datalist!;
    int localPage = page + 1;
    setState(() {
      result;
      loading = false;
      page = localPage;
    });
  }


  void fetchNextPage() {
    scrollController.addListener(() async {
      if(loading) return;
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        getData(userToken, userId, page);
        setState(() {
          loading = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 600,
        child: ListView.builder(
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
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    ListTile(
                      leading: result[index].direction == 'clicktocall' && result[index].callstatus == 'answered' ? Icon(Icons.call_made, color: Colors.green) : Icon(Icons.call_received, color: Colors.red),
                      title: Text(
                        '${result[index].custName} (${result[index].leadId})',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, wordSpacing: 5),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${result[index].mdate} ${result[index].project}',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black, wordSpacing: 3),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${result[index].agent} ${result[index].leadQuality}',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black, wordSpacing: 3),
                          ),
                        ],
                      ),
                      trailing: Container(
                          margin: EdgeInsets.only(bottom: 50.0),
                          child: Icon(Icons.more_vert, color: Colors.black,)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/view.png',
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          'assets/images/plus.png',
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          'assets/images/impclient.png',
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          'assets/images/lead-view.png',
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          'assets/images/messages.png',
                          width: 40,
                          height: 40,
                        ),
                        Image.asset(
                          'assets/images/whatsapp.png',
                          width: 40,
                          height: 40,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
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
}
