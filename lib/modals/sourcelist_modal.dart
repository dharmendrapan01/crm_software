class SourceListModal {
  List<Sourcelist>? sourcelist;

  SourceListModal({this.sourcelist});

  SourceListModal.fromJson(Map<String, dynamic> json) {
    if (json['sourcelist'] != null) {
      sourcelist = <Sourcelist>[];
      json['sourcelist'].forEach((v) {
        sourcelist!.add(new Sourcelist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sourcelist != null) {
      data['sourcelist'] = this.sourcelist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sourcelist {
  String? sourceId;
  String? sourceName;

  Sourcelist({this.sourceId, this.sourceName});

  Sourcelist.fromJson(Map<String, dynamic> json) {
    sourceId = json['sourceId'];
    sourceName = json['sourceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sourceId'] = this.sourceId;
    data['sourceName'] = this.sourceName;
    return data;
  }
}
