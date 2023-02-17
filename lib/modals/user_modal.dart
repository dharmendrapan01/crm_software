class UserModalClass {
  List<Userlist>? userlist;

  UserModalClass({this.userlist});

  UserModalClass.fromJson(Map<String, dynamic> json) {
    if (json['userlist'] != null) {
      userlist = <Userlist>[];
      json['userlist'].forEach((v) {
        userlist!.add(new Userlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userlist != null) {
      data['userlist'] = this.userlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Userlist {
  String? userId;
  String? userName;

  Userlist({this.userId, this.userName});

  Userlist.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    return data;
  }
}
