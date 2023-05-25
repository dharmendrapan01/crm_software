class User {
  int? startfrom;
  int? totalpage;
  String? totalrecord;
  int? page;
  int? numrecperpage;
  List<Datalist>? datalist;

  User(
      {this.startfrom,
        this.totalpage,
        this.totalrecord,
        this.page,
        this.numrecperpage,
        this.datalist});

  User.fromJson(Map<String, dynamic> json) {
    startfrom = json['startfrom'];
    totalpage = json['totalpage'];
    totalrecord = json['totalrecord'];
    page = json['page'];
    numrecperpage = json['numrecperpage'];
    if (json['datalist'] != null) {
      datalist = <Datalist>[];
      json['datalist'].forEach((v) {
        datalist!.add(new Datalist.fromJson(v));
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
    if (this.datalist != null) {
      data['datalist'] = this.datalist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datalist {
  String? custName;
  String? agent;
  String? leadId;
  String? mdate;
  String? project;
  String? leadQuality;
  String? direction;
  String? callstatus;
  String? nomasked;
  String? mobileno;
  String? agentmobile;
  String? callerid;
  String? favorite;

  Datalist(
      {this.custName,
        this.agent,
        this.leadId,
        this.mdate,
        this.project,
        this.leadQuality,
        this.direction,
        this.callstatus,
        this.nomasked,
        this.mobileno,
        this.agentmobile,
        this.callerid,
        this.favorite,
      });

  Datalist.fromJson(Map<String, dynamic> json) {
    custName = json['custName'];
    agent = json['agent'];
    leadId = json['leadId'];
    mdate = json['mdate'];
    project = json['project'];
    leadQuality = json['leadQuality'];
    direction = json['direction'];
    callstatus = json['callstatus'];
    nomasked = json['nomasked'];
    mobileno = json['mobileno'];
    agentmobile = json['agentmobile'];
    callerid = json['callerid'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custName'] = this.custName;
    data['agent'] = this.agent;
    data['leadId'] = this.leadId;
    data['mdate'] = this.mdate;
    data['project'] = this.project;
    data['leadQuality'] = this.leadQuality;
    data['direction'] = this.direction;
    data['callstatus'] = this.callstatus;
    data['nomasked'] = this.nomasked;
    data['mobileno'] = this.mobileno;
    data['agentmobile'] = this.agentmobile;
    data['callerid'] = this.callerid;
    data['favorite'] = this.favorite;
    return data;
  }
}
