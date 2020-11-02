class BannerModel {
  List<Data> data;
  bool success;

  BannerModel({this.data, this.success});

  BannerModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  bool status;
  String sId;
  String name;
  String description;
  int sortOrder;
  String link;
  String image;
  String dateAdded;
  String dateModified;
  int iV;

  Data(
      {this.status,
        this.sId,
        this.name,
        this.description,
        this.sortOrder,
        this.link,
        this.image,
        this.dateAdded,
        this.dateModified,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    sortOrder = json['sort_order'];
    link = json['link'];
    image = json['image'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['sort_order'] = this.sortOrder;
    data['link'] = this.link;
    data['image'] = this.image;
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['__v'] = this.iV;
    return data;
  }
}
