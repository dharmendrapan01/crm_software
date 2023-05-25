class MeetingPlanRemModal {
  int? startfrom;
  int? totalpage;
  String? totalrecord;
  int? page;
  int? numrecperpage;
  List<Meetinglist>? meetinglist;

  MeetingPlanRemModal(
      {this.startfrom,
        this.totalpage,
        this.totalrecord,
        this.page,
        this.numrecperpage,
        this.meetinglist});

  MeetingPlanRemModal.fromJson(Map<String, dynamic> json) {
    startfrom = json['startfrom'];
    totalpage = json['totalpage'];
    totalrecord = json['totalrecord'];
    page = json['page'];
    numrecperpage = json['numrecperpage'];
    if (json['meetinglist'] != null) {
      meetinglist = <Meetinglist>[];
      json['meetinglist'].forEach((v) {
        meetinglist!.add(new Meetinglist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startfrom'] = this.startfrom;
    data['totalpage'] = this.totalpage;
    data['totalrecord'] = this.totalrecord;
    data['page'] = this.page;
    data['numrecperpage'] = this.numrecperpage;
    if (this.meetinglist != null) {
      data['meetinglist'] = this.meetinglist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meetinglist {
  String? custName;
  String? agent;
  String? leadId;
  String? planDate;
  String? project;
  String? leadQuality;
  String? nomasked;
  String? mobileno;
  String? agentmobile;
  String? callerid;
  String? favorite;
  String? metstatus;
  String? meetingId;

  Meetinglist(
      {this.custName,
        this.agent,
        this.leadId,
        this.planDate,
        this.project,
        this.leadQuality,
        this.nomasked,
        this.mobileno,
        this.agentmobile,
        this.callerid,
        this.favorite,
        this.metstatus,
        this.meetingId
      });

  Meetinglist.fromJson(Map<String, dynamic> json) {
    custName = json['custName'];
    agent = json['agent'];
    leadId = json['leadId'];
    planDate = json['plan_date'];
    project = json['project'];
    leadQuality = json['leadQuality'];
    nomasked = json['nomasked'];
    mobileno = json['mobileno'];
    agentmobile = json['agentmobile'];
    callerid = json['callerid'];
    favorite = json['favorite'];
    metstatus = json['metstatus'];
    meetingId = json['meetingId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custName'] = this.custName;
    data['agent'] = this.agent;
    data['leadId'] = this.leadId;
    data['plan_date'] = this.planDate;
    data['project'] = this.project;
    data['leadQuality'] = this.leadQuality;
    data['nomasked'] = this.nomasked;
    data['mobileno'] = this.mobileno;
    data['agentmobile'] = this.agentmobile;
    data['callerid'] = this.callerid;
    data['favorite'] = this.favorite;
    data['metstatus'] = this.metstatus;
    data['meetingId'] = this.meetingId;
    return data;
  }
}
