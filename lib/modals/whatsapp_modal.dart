class WhatsappModal {
  int? startfrom;
  int? totalpage;
  String? totalrecord;
  int? page;
  int? numrecperpage;
  List<Whatsapplist>? whatsapplist;

  WhatsappModal(
      {this.startfrom,
        this.totalpage,
        this.totalrecord,
        this.page,
        this.numrecperpage,
        this.whatsapplist});

  WhatsappModal.fromJson(Map<String, dynamic> json) {
    startfrom = json['startfrom'];
    totalpage = json['totalpage'];
    totalrecord = json['totalrecord'];
    page = json['page'];
    numrecperpage = json['numrecperpage'];
    if (json['whatsapplist'] != null) {
      whatsapplist = <Whatsapplist>[];
      json['whatsapplist'].forEach((v) {
        whatsapplist!.add(new Whatsapplist.fromJson(v));
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
    if (this.whatsapplist != null) {
      data['whatsapplist'] = this.whatsapplist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Whatsapplist {
  String? leadId;
  String? cname;
  String? dataType;
  String? lQuality;
  String? whdate;

  Whatsapplist(
      {this.leadId, this.cname, this.dataType, this.lQuality, this.whdate});

  Whatsapplist.fromJson(Map<String, dynamic> json) {
    leadId = json['leadId'];
    cname = json['cname'];
    dataType = json['dataType'];
    lQuality = json['lQuality'];
    whdate = json['whdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadId'] = this.leadId;
    data['cname'] = this.cname;
    data['dataType'] = this.dataType;
    data['lQuality'] = this.lQuality;
    data['whdate'] = this.whdate;
    return data;
  }
}
