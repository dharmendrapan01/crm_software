class ProjectListModal {
  List<Projectlist>? projectlist;

  ProjectListModal({this.projectlist});

  ProjectListModal.fromJson(Map<String, dynamic> json) {
    if (json['projectlist'] != null) {
      projectlist = <Projectlist>[];
      json['projectlist'].forEach((v) {
        projectlist!.add(new Projectlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.projectlist != null) {
      data['projectlist'] = this.projectlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Projectlist {
  String? projectname;
  String? locationname;

  Projectlist({this.projectname, this.locationname});

  Projectlist.fromJson(Map<String, dynamic> json) {
    projectname = json['projectname'];
    locationname = json['locationname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectname'] = this.projectname;
    data['locationname'] = this.locationname;
    return data;
  }
}
