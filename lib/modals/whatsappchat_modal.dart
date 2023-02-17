class WhatsappchatModal {
  List<Whatsappchat>? whatsappchat;

  WhatsappchatModal({this.whatsappchat});

  WhatsappchatModal.fromJson(Map<String, dynamic> json) {
    if (json['whatsappchat'] != null) {
      whatsappchat = <Whatsappchat>[];
      json['whatsappchat'].forEach((v) {
        whatsappchat!.add(new Whatsappchat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.whatsappchat != null) {
      data['whatsappchat'] = this.whatsappchat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Whatsappchat {
  String? whatname;
  String? whtext;
  String? whfile;
  String? createdate;
  String? whdirection;
  String? whStatus;
  String? filename;
  String? fileext;
  String? whtype;
  double? loclat;
  double? localang;

  Whatsappchat(
      {this.whatname,
        this.whtext,
        this.whfile,
        this.createdate,
        this.whdirection,
        this.whStatus,
        this.filename,
        this.fileext,
        this.whtype,
        this.loclat,
        this.localang});

  Whatsappchat.fromJson(Map<String, dynamic> json) {
    whatname = json['whatname'];
    whtext = json['whtext'];
    whfile = json['whfile'];
    createdate = json['createdate'];
    whdirection = json['whdirection'];
    whStatus = json['whStatus'];
    filename = json['filename'];
    fileext = json['fileext'];
    whtype = json['whtype'];
    loclat = json['loclat'] == null ? 0.0 : json['loclat'].toDouble();
    localang = json['localang'] == null ? 0.0 : json['localang'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['whatname'] = this.whatname;
    data['whtext'] = this.whtext;
    data['whfile'] = this.whfile;
    data['createdate'] = this.createdate;
    data['whdirection'] = this.whdirection;
    data['whStatus'] = this.whStatus;
    data['filename'] = this.filename;
    data['fileext'] = this.fileext;
    data['whtype'] = this.whtype;
    data['loclat'] = this.loclat;
    data['localang'] = this.localang;
    return data;
  }
}
