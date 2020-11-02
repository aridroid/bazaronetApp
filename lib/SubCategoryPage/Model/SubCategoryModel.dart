class SubCategoryModel {
  List<Data> data;
  bool success;

  SubCategoryModel({this.data, this.success});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
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
  Category category;
  String name;
  int sortOrder;
  String description;
  String image;
  String dateAdded;
  String dateModified;
  int iV;

  Data(
      {this.status,
        this.sId,
        this.category,
        this.name,
        this.sortOrder,
        this.description,
        this.image,
        this.dateAdded,
        this.dateModified,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    name = json['name'];
    sortOrder = json['sort_order'];
    description = json['description'];
    image = json['image'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['name'] = this.name;
    data['sort_order'] = this.sortOrder;
    data['description'] = this.description;
    data['image'] = this.image;
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['__v'] = this.iV;
    return data;
  }
}

class Category {
  bool status;
  String sId;
  String name;
  int sortOrder;
  String description;
  String image;
  String dateAdded;
  String dateModified;
  int iV;

  Category(
      {this.status,
        this.sId,
        this.name,
        this.sortOrder,
        this.description,
        this.image,
        this.dateAdded,
        this.dateModified,
        this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    name = json['name'];
    sortOrder = json['sort_order'];
    description = json['description'];
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
    data['sort_order'] = this.sortOrder;
    data['description'] = this.description;
    data['image'] = this.image;
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['__v'] = this.iV;
    return data;
  }
}
