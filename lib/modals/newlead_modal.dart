class NewleadModal {
  int? startfrom;
  int? totalpage;
  String? totalrecord;
  int? page;
  int? numrecperpage;
  List<Newleadlist>? newleadlist;

  NewleadModal(
      {this.startfrom,
        this.totalpage,
        this.totalrecord,
        this.page,
        this.numrecperpage,
        this.newleadlist});

  NewleadModal.fromJson(Map<String, dynamic> json) {
    startfrom = json['startfrom'];
    totalpage = json['totalpage'];
    totalrecord = json['totalrecord'];
    page = json['page'];
    numrecperpage = json['numrecperpage'];
    if (json['newleadlist'] != null) {
      newleadlist = <Newleadlist>[];
      json['newleadlist'].forEach((v) {
        newleadlist!.add(new Newleadlist.fromJson(v));
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
    if (this.newleadlist != null) {
      data['newleadlist'] = this.newleadlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Newleadlist {
  String? leadId;
  String? cname;
  String? createdate;
  String? mobile;
  String? project;
  String? agent;
  String? assignId;
  String? favorite;
  String? leadQuality;
  String? nomasked;

  Newleadlist(
      {this.leadId,
        this.cname,
        this.createdate,
        this.mobile,
        this.project,
        this.agent,
        this.assignId,
        this.favorite,
        this.leadQuality,
        this.nomasked});

  Newleadlist.fromJson(Map<String, dynamic> json) {
    leadId = json['leadId'];
    cname = json['cname'];
    createdate = json['createdate'];
    mobile = json['mobile'];
    project = json['project'];
    agent = json['agent'];
    assignId = json['assign_id'];
    favorite = json['favorite'];
    leadQuality = json['leadQuality'];
    nomasked = json['nomasked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadId'] = this.leadId;
    data['cname'] = this.cname;
    data['createdate'] = this.createdate;
    data['mobile'] = this.mobile;
    data['project'] = this.project;
    data['agent'] = this.agent;
    data['assign_id'] = this.assignId;
    data['favorite'] = this.favorite;
    data['leadQuality'] = this.leadQuality;
    data['nomasked'] = this.nomasked;
    return data;
  }
}
