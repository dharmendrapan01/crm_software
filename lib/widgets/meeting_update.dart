import 'package:flutter/material.dart';

import '../screen/update_meeting.dart';

class MeetingUpdate extends StatefulWidget {
  final meetingId;
  const MeetingUpdate({Key? key, this.meetingId}) : super(key: key);

  @override
  State<MeetingUpdate> createState() => _MeetingUpdateState();
}

class _MeetingUpdateState extends State<MeetingUpdate> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildUpdateBody(),
      ],
    );
  }

  Widget _buildUpdateBody() {
    TabController _tabController = TabController(length: 1, initialIndex: 0, vsync: this);
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      child: Column(
        children: [
          SizedBox(height: 10,),
          TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.orange,
            ),
            controller: _tabController,
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Tab(child: Text('Update Meeting Status', style: TextStyle(color: Colors.black),),),
            ],
          ),
          
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                UpdateMeeting(),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
