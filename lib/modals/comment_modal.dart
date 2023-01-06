class CommentModal {
  List<Commentdata>? commentdata;

  CommentModal({this.commentdata});

  CommentModal.fromJson(Map<String, dynamic> json) {
    if (json['commentdata'] != null) {
      commentdata = <Commentdata>[];
      json['commentdata'].forEach((v) {
        commentdata!.add(new Commentdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commentdata != null) {
      data['commentdata'] = this.commentdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Commentdata {
  String? calldate;
  String? comment;

  Commentdata({this.calldate, this.comment});

  Commentdata.fromJson(Map<String, dynamic> json) {
    calldate = json['calldate'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calldate'] = this.calldate;
    data['comment'] = this.comment;
    return data;
  }
}
