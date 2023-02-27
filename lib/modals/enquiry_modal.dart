class EnquiryModal {
  int? startfrom;
  int? totalpage;
  String? totalrecord;
  String? page;
  int? numrecperpage;
  List<Enqlist>? enqlist;

  EnquiryModal(
      {this.startfrom,
        this.totalpage,
        this.totalrecord,
        this.page,
        this.numrecperpage,
        this.enqlist});

  EnquiryModal.fromJson(Map<String, dynamic> json) {
    startfrom = json['startfrom'];
    totalpage = json['totalpage'];
    totalrecord = json['totalrecord'];
    page = json['page'];
    numrecperpage = json['numrecperpage'];
    if (json['enqlist'] != null) {
      enqlist = <Enqlist>[];
      json['enqlist'].forEach((v) {
        enqlist!.add(new Enqlist.fromJson(v));
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
    if (this.enqlist != null) {
      data['enqlist'] = this.enqlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Enqlist {
  String? leadId;
  String? cname;
  String? dataType;
  String? lQuality;
  String? lbudget;
  String? assignto;
  String? cdate;
  String? mdate;
  String? source;
  String? project;
  String? audioUrl;
  String? comment;
  String? assignDate;
  String? mobile;
  String? svcount;
  String? metcount;
  String? duplicacy;
  String? assignId;
  String? nomasked;
  String? createby;
  String? duplicate;
  String? parentid;
  String? status;
  String? sourceid;
  String? ducount;
  String? mobilereq;
  String? mobileC2c;
  String? favorite;
  String? agentmobile;

  Enqlist(
      {this.leadId,
        this.cname,
        this.dataType,
        this.lQuality,
        this.lbudget,
        this.assignto,
        this.cdate,
        this.mdate,
        this.source,
        this.project,
        this.audioUrl,
        this.comment,
        this.assignDate,
        this.mobile,
        this.svcount,
        this.metcount,
        this.duplicacy,
        this.assignId,
        this.nomasked,
        this.createby,
        this.duplicate,
        this.parentid,
        this.status,
        this.sourceid,
        this.ducount,
        this.mobilereq,
        this.mobileC2c,
        this.favorite,
        this.agentmobile
      });

  Enqlist.fromJson(Map<String, dynamic> json) {
    leadId = json['leadId'];
    cname = json['cname'];
    dataType = json['dataType'];
    lQuality = json['lQuality'];
    lbudget = json['lbudget'];
    assignto = json['assignto'];
    cdate = json['cdate'];
    mdate = json['mdate'];
    source = json['source'];
    project = json['project'];
    audioUrl = json['audio_url'];
    comment = json['comment'];
    assignDate = json['assign_date'];
    mobile = json['mobile'];
    svcount = json['svcount'];
    metcount = json['metcount'];
    duplicacy = json['duplicacy'];
    assignId = json['assign_id'];
    nomasked = json['nomasked'];
    createby = json['createby'];
    duplicate = json['duplicate'];
    parentid = json['parentid'];
    status = json['status'];
    sourceid = json['sourceid'];
    ducount = json['ducount'];
    mobilereq = json['mobilereq'];
    mobileC2c = json['mobile_c2c'];
    favorite = json['favorite'];
    agentmobile = json['agentmobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadId'] = this.leadId;
    data['cname'] = this.cname;
    data['dataType'] = this.dataType;
    data['lQuality'] = this.lQuality;
    data['lbudget'] = this.lbudget;
    data['assignto'] = this.assignto;
    data['cdate'] = this.cdate;
    data['mdate'] = this.mdate;
    data['source'] = this.source;
    data['project'] = this.project;
    data['audio_url'] = this.audioUrl;
    data['comment'] = this.comment;
    data['assign_date'] = this.assignDate;
    data['mobile'] = this.mobile;
    data['svcount'] = this.svcount;
    data['metcount'] = this.metcount;
    data['duplicacy'] = this.duplicacy;
    data['assign_id'] = this.assignId;
    data['nomasked'] = this.nomasked;
    data['createby'] = this.createby;
    data['duplicate'] = this.duplicate;
    data['parentid'] = this.parentid;
    data['status'] = this.status;
    data['sourceid'] = this.sourceid;
    data['ducount'] = this.ducount;
    data['mobilereq'] = this.mobilereq;
    data['mobile_c2c'] = this.mobileC2c;
    data['favorite'] = this.favorite;
    data['agentmobile'] = this.agentmobile;
    return data;
  }
}
