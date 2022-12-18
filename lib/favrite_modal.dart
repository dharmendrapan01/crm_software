

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.startfrom,
    required this.totalpage,
    required this.totalrecord,
    required this.page,
    required this.numrecperpage,
    required this.datalist,
  });

  int startfrom;
  int totalpage;
  String totalrecord;
  String page;
  int numrecperpage;
  List<Datalist> datalist;

  factory User.fromJson(Map<String, dynamic> json) => User(
    startfrom: json["startfrom"],
    totalpage: json["totalpage"],
    totalrecord: json["totalrecord"],
    page: json["page"],
    numrecperpage: json["numrecperpage"],
    datalist: List<Datalist>.from(json["datalist"].map((x) => Datalist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "startfrom": startfrom,
    "totalpage": totalpage,
    "totalrecord": totalrecord,
    "page": page,
    "numrecperpage": numrecperpage,
    "datalist": List<dynamic>.from(datalist.map((x) => x.toJson())),
  };
}

class Datalist {
  Datalist({
    required this.custName,
    required this.agent,
    required this.leadId,
    required this.mdate,
    required this.project,
    required this.leadQuality,
  });

  String custName;
  Agent? agent;
  String leadId;
  String mdate;
  String project;
  LeadQuality? leadQuality;

  factory Datalist.fromJson(Map<String, dynamic> json) => Datalist(
    custName: json["custName"],
    agent: agentValues.map[json["agent"]],
    leadId: json["leadId"],
    mdate: json["mdate"],
    project: json["project"],
    leadQuality: leadQualityValues.map[json["leadQuality"]],
  );

  Map<String, dynamic> toJson() => {
    "custName": custName,
    "agent": agentValues.reverse[agent],
    "leadId": leadId,
    "mdate": mdate,
    "project": project,
    "leadQuality": leadQualityValues.reverse[leadQuality],
  };
}

enum Agent { ANMOL_KUMAR, SUDHIR_KUMAR, AMIT_KR_GEHLOT }

final agentValues = EnumValues({
  "Amit Kr Gehlot": Agent.AMIT_KR_GEHLOT,
  "Anmol Kumar": Agent.ANMOL_KUMAR,
  "Sudhir Kumar": Agent.SUDHIR_KUMAR
});

enum LeadQuality { NA, QUALIFIED, STATUS_UNKNOWN }

final leadQualityValues = EnumValues({
  "NA": LeadQuality.NA,
  "Qualified": LeadQuality.QUALIFIED,
  "Status Unknown": LeadQuality.STATUS_UNKNOWN
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
