import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sticky_headers/sticky_headers/widget.dart';
import 'call_history.dart';
import 'login_page.dart';
import 'package:crm_software/user_preference.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String? userId = '';
  String? userName = '';

  @override
  void initState() {
    super.initState();
    userId = UserPreference.getUserId() ?? '';
    userName = UserPreference.getUserName() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          topHeader(),
          headerSection(),
          bodySection(),
        ],
      ),
    );
  }

  Container topHeader() {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/salesapp.png', width: 100),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [
                Text('Live Call'.toUpperCase(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                SizedBox(width: 3,),
                Icon(Icons.call),
              ],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
          ),
          ElevatedButton(onPressed: () async {
            UserPreference.setUserToken('');
            // SharedPreferences pref = await SharedPreferences.getInstance();
            // await pref.clear();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()), (
                Route<dynamic> route) => false);
          },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: Row(
              children: [
                Text('Log Out'.toUpperCase(), style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500,),),
                SizedBox(width: 3,),
                Icon(Icons.logout),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Container headerSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: ' CRM ID',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    suffixIcon: Icon(Icons.search, color: Colors.green,),
                  ),
                ),
              ),
              SizedBox(width: 5,),
              Expanded(
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: ' MOBILE / NAME',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    suffixIcon: Icon(Icons.search, color: Colors.green,),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$userId',
                style: TextStyle(fontSize: 16, color: Colors.white),),
              Text('Welcome : $userName',
                style: TextStyle(fontSize: 16, color: Colors.white),),
            ],
          ),
        ],
      ),
    );
  }


  Container bodySection() {
    TabController _tabController = TabController(
        length: 9, initialIndex: 0, vsync: this);
    return Container(
      height: double.maxFinite,
      child: Column(
        children: [
          SizedBox(height: 5,),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.orange,
                ),
                controller: _tabController,
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                tabs: [
                  Tab(child: Text(
                    'ALL', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text(
                    'FAVORITE', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text(
                    'QUALIFIED', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text(
                    'WEB. RECEIVED', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text(
                    'WEB. MISSED', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text(
                    'INC. CALL', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text(
                    'INC. MISSED', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text(
                    'SMS CALL', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text(
                    'SMS MISSED', style: TextStyle(color: Colors.black),),),
                ],
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AllCallHistory(),
                //     ListView.builder(
                //     physics: BouncingScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: 10,
                //     itemBuilder: (context, index){
                //       // final call = calls[index];
                //       // final callid = call['callId'];
                //       return Card(
                //         elevation: 3,
                //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                //         margin: EdgeInsets.symmetric(vertical: 8),
                //         child: Column(
                //           children: [
                //             ListTile(
                //               leading: Icon(Icons.call_missed,color: Colors.red,),
                //               title: Text('fghfghfh', style: TextStyle(fontWeight: FontWeight.bold, wordSpacing: 5),),
                //               subtitle: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   SizedBox(height: 5,),
                //                   Text('7 Dec 22 05:51:40 PM', style: TextStyle(color: Colors.black, wordSpacing: 3),),
                //                   SizedBox(height: 5,),
                //                   Text('Sudhir Kumar Qualified', style: TextStyle(color: Colors.black, wordSpacing: 3),),
                //                 ],
                //               ),
                //               trailing: Icon(Icons.person_off_outlined, color: Colors.red,),
                //             ),
                //             SizedBox(height: 10,),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //               children: [
                //                 Image.asset('assets/images/view.png', width: 40, height: 40,),
                //                 Image.asset('assets/images/plus.png', width: 40, height: 40,),
                //                 Image.asset('assets/images/impclient.png', width: 40, height: 40,),
                //                 Image.asset('assets/images/lead-view.png', width: 40, height: 40,),
                //                 Image.asset('assets/images/messages.png', width: 40, height: 40,),
                //                 Image.asset('assets/images/whatsapp.png', width: 40, height: 40,),
                //               ],
                //             ),
                //             SizedBox(height: 10,),
                //           ],
                //         ),
                //       );
                //     }
                // ),
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
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
                                Icons.call_missed, color: Colors.red,),
                              title: Text('C Name (523015) ${index + 1}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    wordSpacing: 5),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Text('7 Dec 22 05:51:40 PM ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                  SizedBox(height: 5,),
                                  Text('Sudhir Kumar Qualified ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                ],
                              ),
                              trailing: Icon(
                                Icons.person_off_outlined, color: Colors.red,),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/images/view.png', width: 40,
                                  height: 40,),
                                Image.asset('assets/images/plus.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/impclient.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/lead-view.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/messages.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/whatsapp.png', width: 40,
                                  height: 40,),
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      );
                    }
                ),
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
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
                                Icons.call_missed, color: Colors.red,),
                              title: Text('C Name (523015) ${index + 1}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    wordSpacing: 5),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Text('7 Dec 22 05:51:40 PM ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                  SizedBox(height: 5,),
                                  Text('Sudhir Kumar Qualified ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                ],
                              ),
                              trailing: Icon(
                                Icons.person_off_outlined, color: Colors.red,),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/images/view.png', width: 40,
                                  height: 40,),
                                Image.asset('assets/images/plus.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/impclient.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/lead-view.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/messages.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/whatsapp.png', width: 40,
                                  height: 40,),
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      );
                    }
                ),
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
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
                                Icons.call_missed, color: Colors.red,),
                              title: Text('C Name (523015) ${index + 1}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    wordSpacing: 5),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Text('7 Dec 22 05:51:40 PM ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                  SizedBox(height: 5,),
                                  Text('Sudhir Kumar Qualified ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                ],
                              ),
                              trailing: Icon(
                                Icons.person_off_outlined, color: Colors.red,),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/images/view.png', width: 40,
                                  height: 40,),
                                Image.asset('assets/images/plus.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/impclient.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/lead-view.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/messages.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/whatsapp.png', width: 40,
                                  height: 40,),
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      );
                    }
                ),
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
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
                                Icons.call_missed, color: Colors.red,),
                              title: Text('C Name (523015) ${index + 1}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    wordSpacing: 5),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Text('7 Dec 22 05:51:40 PM ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                  SizedBox(height: 5,),
                                  Text('Sudhir Kumar Qualified ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                ],
                              ),
                              trailing: Icon(
                                Icons.person_off_outlined, color: Colors.red,),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/images/view.png', width: 40,
                                  height: 40,),
                                Image.asset('assets/images/plus.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/impclient.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/lead-view.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/messages.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/whatsapp.png', width: 40,
                                  height: 40,),
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      );
                    }
                ),
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
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
                                Icons.call_missed, color: Colors.red,),
                              title: Text('C Name (523015) ${index + 1}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    wordSpacing: 5),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Text('7 Dec 22 05:51:40 PM ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                  SizedBox(height: 5,),
                                  Text('Sudhir Kumar Qualified ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                ],
                              ),
                              trailing: Icon(
                                Icons.person_off_outlined, color: Colors.red,),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/images/view.png', width: 40,
                                  height: 40,),
                                Image.asset('assets/images/plus.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/impclient.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/lead-view.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/messages.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/whatsapp.png', width: 40,
                                  height: 40,),
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      );
                    }
                ),
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
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
                                Icons.call_missed, color: Colors.red,),
                              title: Text('C Name (523015) ${index + 1}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    wordSpacing: 5),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Text('7 Dec 22 05:51:40 PM ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                  SizedBox(height: 5,),
                                  Text('Sudhir Kumar Qualified ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                ],
                              ),
                              trailing: Icon(
                                Icons.person_off_outlined, color: Colors.red,),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/images/view.png', width: 40,
                                  height: 40,),
                                Image.asset('assets/images/plus.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/impclient.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/lead-view.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/messages.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/whatsapp.png', width: 40,
                                  height: 40,),
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      );
                    }
                ),
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
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
                                Icons.call_missed, color: Colors.red,),
                              title: Text('C Name (523015) ${index + 1}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    wordSpacing: 5),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Text('7 Dec 22 05:51:40 PM ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                  SizedBox(height: 5,),
                                  Text('Sudhir Kumar Qualified ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                ],
                              ),
                              trailing: Icon(
                                Icons.person_off_outlined, color: Colors.red,),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/images/view.png', width: 40,
                                  height: 40,),
                                Image.asset('assets/images/plus.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/impclient.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/lead-view.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/messages.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/whatsapp.png', width: 40,
                                  height: 40,),
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      );
                    }
                ),
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
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
                                Icons.call_missed, color: Colors.red,),
                              title: Text('C Name (523015) ${index + 1}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    wordSpacing: 5),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Text('7 Dec 22 05:51:40 PM ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                  SizedBox(height: 5,),
                                  Text('Sudhir Kumar Qualified ${index + 1}',
                                    style: TextStyle(
                                        color: Colors.black, wordSpacing: 3),),
                                ],
                              ),
                              trailing: Icon(
                                Icons.person_off_outlined, color: Colors.red,),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/images/view.png', width: 40,
                                  height: 40,),
                                Image.asset('assets/images/plus.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/impclient.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/lead-view.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/messages.png', width: 40,
                                  height: 40,),
                                Image.asset(
                                  'assets/images/whatsapp.png', width: 40,
                                  height: 40,),
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}