class FocucedProject {
  List<Focusedproject>? focusedproject;

  FocucedProject({this.focusedproject});

  FocucedProject.fromJson(Map<String, dynamic> json) {
    if (json['focusedproject'] != null) {
      focusedproject = <Focusedproject>[];
      json['focusedproject'].forEach((v) {
        focusedproject!.add(new Focusedproject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.focusedproject != null) {
      data['focusedproject'] =
          this.focusedproject!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Focusedproject {
  String? leadid;
  String? projfolder;
  String? logoimage;

  Focusedproject({this.leadid, this.projfolder, this.logoimage});

  Focusedproject.fromJson(Map<String, dynamic> json) {
    leadid = json['leadid'];
    projfolder = json['projfolder'];
    logoimage = json['logoimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadid'] = this.leadid;
    data['projfolder'] = this.projfolder;
    data['logoimage'] = this.logoimage;
    return data;
  }
}
