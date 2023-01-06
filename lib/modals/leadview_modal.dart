class LeadViewModal {
  List<Leaddata>? leaddata;

  LeadViewModal({this.leaddata});

  LeadViewModal.fromJson(Map<String, dynamic> json) {
    if (json['leaddata'] != null) {
      leaddata = <Leaddata>[];
      json['leaddata'].forEach((v) {
        leaddata!.add(new Leaddata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaddata != null) {
      data['leaddata'] = this.leaddata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leaddata {
  String? custName;
  String? agent;
  String? leadId;
  String? mdate;
  String? project;
  String? leadQuality;
  String? nomasked;
  String? mobileno;
  String? agentmobile;
  String? callerid;
  String? favorite;
  String? datatype;
  String? budget;
  String? temprature;
  String? svcount;

  Leaddata(
      {this.custName,
        this.agent,
        this.leadId,
        this.mdate,
        this.project,
        this.leadQuality,
        this.nomasked,
        this.mobileno,
        this.agentmobile,
        this.callerid,
        this.favorite,
        this.datatype,
        this.budget,
        this.temprature,
        this.svcount,
      });

  Leaddata.fromJson(Map<String, dynamic> json) {
    custName = json['custName'];
    agent = json['agent'];
    leadId = json['leadId'];
    mdate = json['mdate'];
    project = json['project'];
    leadQuality = json['leadQuality'];
    nomasked = json['nomasked'];
    mobileno = json['mobileno'];
    agentmobile = json['agentmobile'];
    callerid = json['callerid'];
    favorite = json['favorite'];
    datatype = json['datatype'];
    budget = json['budget'];
    temprature = json['temprature'];
    svcount = json['svcount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custName'] = this.custName;
    data['agent'] = this.agent;
    data['leadId'] = this.leadId;
    data['mdate'] = this.mdate;
    data['project'] = this.project;
    data['leadQuality'] = this.leadQuality;
    data['nomasked'] = this.nomasked;
    data['mobileno'] = this.mobileno;
    data['agentmobile'] = this.agentmobile;
    data['callerid'] = this.callerid;
    data['favorite'] = this.favorite;
    data['datatype'] = this.datatype;
    data['budget'] = this.budget;
    data['temprature'] = this.temprature;
    data['svcount'] = this.svcount;
    return data;
  }
}
