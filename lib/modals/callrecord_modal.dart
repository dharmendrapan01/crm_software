class RecordingModal {
  List<Audiodata>? audiodata;

  RecordingModal({this.audiodata});

  RecordingModal.fromJson(Map<String, dynamic> json) {
    if (json['audiodata'] != null) {
      audiodata = <Audiodata>[];
      json['audiodata'].forEach((v) {
        audiodata!.add(new Audiodata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.audiodata != null) {
      data['audiodata'] = this.audiodata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Audiodata {
  String? calldate;
  String? calldirection;
  String? callstatus;
  String? callduration;
  String? audiourl;
  String? callednumber;
  String? leadid;

  Audiodata(
      {this.calldate,
        this.calldirection,
        this.callstatus,
        this.callduration,
        this.audiourl,
        this.callednumber,
        this.leadid,
      });

  Audiodata.fromJson(Map<String, dynamic> json) {
    calldate = json['calldate'];
    calldirection = json['calldirection'];
    callstatus = json['callstatus'];
    callduration = json['callduration'];
    audiourl = json['audiourl'];
    callednumber = json['callednumber'];
    leadid = json['leadid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calldate'] = this.calldate;
    data['calldirection'] = this.calldirection;
    data['callstatus'] = this.callstatus;
    data['callduration'] = this.callduration;
    data['audiourl'] = this.audiourl;
    data['callednumber'] = this.callednumber;
    data['leadid'] = this.leadid;
    return data;
  }
}
