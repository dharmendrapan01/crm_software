class MenuPageModal {
  List<Items>? items;

  MenuPageModal({this.items});

  MenuPageModal.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? name;
  String? menuIcon;
  String? menucolor;
  String? menucount;
  String? menulink;

  Items({this.id, this.name, this.menuIcon, this.menucolor, this.menucount, this.menulink});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    menuIcon = json['menu_icon'];
    menucolor = json['menucolor'];
    menucount = json['menucount'];
    menulink = json['menulink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['menu_icon'] = this.menuIcon;
    data['menucolor'] = this.menucolor;
    data['menucount'] = this.menucount;
    data['menulink'] = this.menulink;
    return data;
  }
}
