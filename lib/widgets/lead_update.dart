import 'package:crm_software/add_comment.dart';
import 'package:crm_software/meeting_done.dart';
import 'package:crm_software/meeting_plan.dart';
import 'package:crm_software/update_qualified.dart';
import 'package:flutter/material.dart';

import '../delete_lead.dart';
import '../status_unknown.dart';
import '../voicecall_done.dart';
import '../voicecall_plan.dart';

class LeadUpdate extends StatefulWidget {
  final leadId;
  const LeadUpdate({Key? key, this.leadId}) : super(key: key);

  @override
  State<LeadUpdate> createState() => _LeadUpdateState();
}

class _LeadUpdateState extends State<LeadUpdate> with TickerProviderStateMixin {
  int tabIndex = 0;
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 8, vsync: this);
    tabController.addListener(() {
      if(tabController.indexIsChanging){
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text('CLOSE', style: TextStyle(color: Colors.white, fontSize: 20.0),),
                ),
              ),
              Text('UPDATE LEAD ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),),
            ],
          ),
          bodyUpdateSection(widget.leadId),
        ],
      );
  }




  Container bodyUpdateSection(leadId) {
    return Container(
      // height: tabIndex == 0 ? MediaQuery.of(context).size.height * 0.86 : MediaQuery.of(context).size.height * 0.20,
      height: MediaQuery.of(context).size.height * 0.86,
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
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
                controller: tabController,
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                tabs: [
                  Tab(child: Text('QUALIFIED', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('ADD COMMENT', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('MEET PLAN', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('MEET DONE', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('CALL PLAN', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('CALL DONE', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('DEL LEAD', style: TextStyle(color: Colors.black),),),
                  Tab(child: Text('STATUS UNK', style: TextStyle(color: Colors.black),),),
                ],
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
                children: [
                  UpdateQualified(leadId: leadId),
                  AddComment(leadId: leadId),
                  MeetingPlan(leadId: leadId),
                  MeetingDone(leadId: leadId),
                  VoiceCallPlan(leadId: leadId),
                  VoiceCallDone(leadId: leadId),
                  DeleteLead(leadId: leadId),
                  StatusUnknown(leadId: leadId),
                ],
            ),
          ),
        ],
      ),
    );
  }


}
