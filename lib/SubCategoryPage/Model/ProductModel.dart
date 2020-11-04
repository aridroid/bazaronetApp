class ProductModel {
  List<Data> data;
  bool success;

  ProductModel({this.data, this.success});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
  Dimensions dimensions;
  int tax;
  List<String> image;
  int shipping;
  int minAmountForFreeShipping;
  bool status;
  String sId;
  String name;
  String model;
  Category category;
  String subcategory;
  String manufacturer;
  int price;
  int actualPrice;
  int stock;
  int unit;
  int quantity;
  String quantityClass;
  String dimensionsClass;
  Null weight;
  String weightClass;
  String description;
  String dateAdded;
  String dateModified;
  int iV;

  Data(
      {this.dimensions,
        this.tax,
        this.image,
        this.shipping,
        this.minAmountForFreeShipping,
        this.status,
        this.sId,
        this.name,
        this.model,
        this.category,
        this.subcategory,
        this.manufacturer,
        this.price,
        this.actualPrice,
        this.stock,
        this.unit,
        this.quantity,
        this.quantityClass,
        this.dimensionsClass,
        this.weight,
        this.weightClass,
        this.description,
        this.dateAdded,
        this.dateModified,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    dimensions = json['dimensions'] != null
        ? new Dimensions.fromJson(json['dimensions'])
        : null;
    tax = json['tax'];
    image = json['image'].cast<String>();
    shipping = json['shipping'];
    minAmountForFreeShipping = json['min_amount_for_free_shipping'];
    status = json['status'];
    sId = json['_id'];
    name = json['name'];
    model = json['model'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subcategory = json['subcategory'];
    manufacturer = json['manufacturer'];
    price = json['price'];
    actualPrice = json['actual_price'];
    stock = json['stock'];
    unit = json['unit'];
    quantity = json['quantity'];
    quantityClass = json['quantity_class'];
    dimensionsClass = json['dimensions_class'];
    weight = json['weight'];
    weightClass = json['weight_class'];
    description = json['description'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions.toJson();
    }
    data['tax'] = this.tax;
    data['image'] = this.image;
    data['shipping'] = this.shipping;
    data['min_amount_for_free_shipping'] = this.minAmountForFreeShipping;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['model'] = this.model;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['subcategory'] = this.subcategory;
    data['manufacturer'] = this.manufacturer;
    data['price'] = this.price;
    data['actual_price'] = this.actualPrice;
    data['stock'] = this.stock;
    data['unit'] = this.unit;
    data['quantity'] = this.quantity;
    data['quantity_class'] = this.quantityClass;
    data['dimensions_class'] = this.dimensionsClass;
    data['weight'] = this.weight;
    data['weight_class'] = this.weightClass;
    data['description'] = this.description;
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['__v'] = this.iV;
    return data;
  }
}

class Dimensions {
  double length;
  double width;
  int height;

  Dimensions({this.length, this.width, this.height});

  Dimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
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
