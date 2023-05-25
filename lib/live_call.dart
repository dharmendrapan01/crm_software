import 'package:crm_software/screen/livecalls_detail.dart';
import 'package:crm_software/widgets/bottom_menue.dart';
import 'package:crm_software/widgets/header_first.dart';
import 'package:crm_software/widgets/header_section.dart';
import 'package:crm_software/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class LiveCall extends StatefulWidget {
  const LiveCall({Key? key}) : super(key: key);

  @override
  State<LiveCall> createState() => _LiveCallState();
}

class _LiveCallState extends State<LiveCall> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        elevation: 0,
        toolbarHeight: 45.0,
        backgroundColor: Colors.white,
        // leadingWidth: 2.0,
        flexibleSpace: SafeArea(
          child: HeaderFirst(),
        ),
      ),
      drawer: MyDrawer(),
      body: Container(
        height: double.maxFinite,
        child: ListView(
          children: [
            HeaderSection(),
            bodySection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }

  Container bodySection() {
    TabController _tabController = TabController(
        length: 1, initialIndex: 0, vsync: this
    );
    return Container(
      height: MediaQuery.of(context).size.height * 0.81,
      child: Column(
        children: [
          // SizedBox(height: 5,),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
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
                  Tab(child: Text('Live Calls', style: TextStyle(color: Colors.black),),),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                LiveCallsDetail(),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
