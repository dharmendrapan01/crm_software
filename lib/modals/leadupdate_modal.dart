class UpdateLead {
  List<Leadupdatepop>? leadupdatepop;

  UpdateLead({this.leadupdatepop});

  UpdateLead.fromJson(Map<String, dynamic> json) {
    if (json['leadupdatepop'] != null) {
      leadupdatepop = <Leadupdatepop>[];
      json['leadupdatepop'].forEach((v) {
        leadupdatepop!.add(new Leadupdatepop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leadupdatepop != null) {
      data['leadupdatepop'] =
          this.leadupdatepop!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leadupdatepop {
  String? custName;
  String? leadId;
  String? project;
  String? qualproject2;
  String? nomasked;
  String? mobileno;
  String? agentmobile;
  String? callerid;
  String? budget;
  String? temprature;
  String? qualifyqual;
  String? proptype;
  String? maxbudgetc;
  String? maxbudgetl;
  String? strongfoloup;
  String? closerpip;
  String? piplinestatus;
  String? vergecloser;
  String? comment;
  String? preflocation1;
  String? preflocation2;

  Leadupdatepop(
      {this.custName,
        this.leadId,
        this.project,
        this.qualproject2,
        this.nomasked,
        this.mobileno,
        this.agentmobile,
        this.callerid,
        this.budget,
        this.temprature,
        this.qualifyqual,
        this.proptype,
        this.maxbudgetc,
        this.maxbudgetl,
        this.strongfoloup,
        this.closerpip,
        this.piplinestatus,
        this.vergecloser,
        this.comment,
        this.preflocation1,
        this.preflocation2,
      });

  Leadupdatepop.fromJson(Map<String, dynamic> json) {
    custName = json['custName'];
    leadId = json['leadId'];
    project = json['project'];
    qualproject2 = json['qualproject2'];
    nomasked = json['nomasked'];
    mobileno = json['mobileno'];
    agentmobile = json['agentmobile'];
    callerid = json['callerid'];
    budget = json['budget'];
    temprature = json['temprature'];
    qualifyqual = json['qualifyqual'];
    proptype = json['proptype'];
    maxbudgetc = json['maxbudgetc'];
    maxbudgetl = json['maxbudgetl'];
    strongfoloup = json['strongfoloup'];
    closerpip = json['closerpip'];
    piplinestatus = json['piplinestatus'];
    vergecloser = json['vergecloser'];
    comment = json['comment'];
    preflocation1 = json['preflocation1'];
    preflocation2 = json['preflocation2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custName'] = this.custName;
    data['leadId'] = this.leadId;
    data['project'] = this.project;
    data['qualproject2'] = this.qualproject2;
    data['nomasked'] = this.nomasked;
    data['mobileno'] = this.mobileno;
    data['agentmobile'] = this.agentmobile;
    data['callerid'] = this.callerid;
    data['budget'] = this.budget;
    data['temprature'] = this.temprature;
    data['qualifyqual'] = this.qualifyqual;
    data['proptype'] = this.proptype;
    data['maxbudgetc'] = this.maxbudgetc;
    data['maxbudgetl'] = this.maxbudgetl;
    data['strongfoloup'] = this.strongfoloup;
    data['closerpip'] = this.closerpip;
    data['piplinestatus'] = this.piplinestatus;
    data['vergecloser'] = this.vergecloser;
    data['comment'] = this.comment;
    data['preflocation1'] = this.preflocation1;
    data['preflocation2'] = this.preflocation2;
    return data;
  }
}
