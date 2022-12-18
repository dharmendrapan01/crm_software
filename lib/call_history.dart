import 'dart:convert';

import 'package:crm_software/user_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'callhistory_modal.dart';

class AllCallHistory extends StatefulWidget {
  const AllCallHistory({Key? key}) : super(key: key);

  @override
  State<AllCallHistory> createState() => _AllCallHistoryState();
}

class _AllCallHistoryState extends State<AllCallHistory> {
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
          'https://spaze-salesapp.com/app/_api/callhistory.php?user_id=144&page_no=$page'),
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
      // print('called scroll');
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        getData(userToken, userId, page);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 625,
        child: ListView.builder(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: result.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.call_missed,
                      color: Colors.red,
                    ),
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
                    trailing: Icon(
                      Icons.person_off_outlined,
                      color: Colors.red,
                    ),
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
          },
        ),
      ),
    );
  }
}
