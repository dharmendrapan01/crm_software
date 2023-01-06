class CliModal {
  List<Clilist>? clilist;

  CliModal({this.clilist});

  CliModal.fromJson(Map<String, dynamic> json) {
    if (json['clilist'] != null) {
      clilist = <Clilist>[];
      json['clilist'].forEach((v) {
        clilist!.add(new Clilist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clilist != null) {
      data['clilist'] = this.clilist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clilist {
  String? clinumber;

  Clilist({this.clinumber});

  Clilist.fromJson(Map<String, dynamic> json) {
    clinumber = json['clinumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clinumber'] = this.clinumber;
    return data;
  }
}
