class CartPageModel {
  List<Data> data;
  bool success;

  CartPageModel({this.data, this.success});

  CartPageModel.fromJson(Map<String, dynamic> json) {
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
  String sId;
  CustomerId customerId;
  Product product;
  int quantity;
  String dateAdded;
  String dateModified;
  int iV;

  Data(
      {this.sId,
        this.customerId,
        this.product,
        this.quantity,
        this.dateAdded,
        this.dateModified,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customer_id'] != null
        ? new CustomerId.fromJson(json['customer_id'])
        : null;
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.customerId != null) {
      data['customer_id'] = this.customerId.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['quantity'] = this.quantity;
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['__v'] = this.iV;
    return data;
  }
}

class CustomerId {
  bool isVerified;
  String role;
  bool status;
  String sId;
  String email;
  String phone;
  String name;
  String password;
  int code;
  String dateAdded;
  String dateModified;
  int iV;

  CustomerId(
      {this.isVerified,
        this.role,
        this.status,
        this.sId,
        this.email,
        this.phone,
        this.name,
        this.password,
        this.code,
        this.dateAdded,
        this.dateModified,
        this.iV});

  CustomerId.fromJson(Map<String, dynamic> json) {
    isVerified = json['isVerified'];
    role = json['role'];
    status = json['status'];
    sId = json['_id'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    password = json['password'];
    code = json['code'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isVerified'] = this.isVerified;
    data['role'] = this.role;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['password'] = this.password;
    data['code'] = this.code;
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['__v'] = this.iV;
    return data;
  }
}

class Product {
  Dimensions dimensions;
  int tax;
  List<String> image;
  int shipping;
  int minAmountForFreeShipping;
  bool status;
  String sId;
  String name;
  String model;
  String category;
  String subcategory;
  String manufacturer;
  int price;
  int actualPrice;
  int stock;
  int unit;
  int quantity;
  String quantityClass;
  String dimensionsClass;
  int weight;
  String weightClass;
  String description;
  String dateAdded;
  String dateModified;
  int iV;

  Product(
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

  Product.fromJson(Map<String, dynamic> json) {
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
    category = json['category'];
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
    data['category'] = this.category;
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
