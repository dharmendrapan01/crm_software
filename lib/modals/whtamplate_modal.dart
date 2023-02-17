class WhatsappTamplate {
  List<Tamplatelist>? tamplatelist;

  WhatsappTamplate({this.tamplatelist});

  WhatsappTamplate.fromJson(Map<String, dynamic> json) {
    if (json['tamplatelist'] != null) {
      tamplatelist = <Tamplatelist>[];
      json['tamplatelist'].forEach((v) {
        tamplatelist!.add(new Tamplatelist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tamplatelist != null) {
      data['tamplatelist'] = this.tamplatelist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tamplatelist {
  String? leadid;
  String? wptamplateid;
  String? wptamplate;

  Tamplatelist({this.leadid, this.wptamplateid, this.wptamplate});

  Tamplatelist.fromJson(Map<String, dynamic> json) {
    leadid = json['leadid'];
    wptamplateid = json['wptamplateid'];
    wptamplate = json['wptamplate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadid'] = this.leadid;
    data['wptamplateid'] = this.wptamplateid;
    data['wptamplate'] = this.wptamplate;
    return data;
  }
}
