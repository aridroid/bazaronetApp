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
  String type;
  int tax;
  List<String> image;
  int shipping;
  int minAmountForFreeShipping;
  bool status;
  String delivery;
  String sId;
  String name;
  String model;
  Category category;
  String subcategory;
  String manufacturer;
  int quantity;
  String description;
  List<Variant> variant;
  VendorId vendorId;
  String dateAdded;
  String dateModified;
  int iV;

  Data(
      {this.type,
        this.tax,
        this.image,
        this.shipping,
        this.minAmountForFreeShipping,
        this.status,
        this.delivery,
        this.sId,
        this.name,
        this.model,
        this.category,
        this.subcategory,
        this.manufacturer,
        this.quantity,
        this.description,
        this.variant,
        this.vendorId,
        this.dateAdded,
        this.dateModified,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    tax = json['tax'];
    image = json['image'].cast<String>();
    shipping = json['shipping'];
    minAmountForFreeShipping = json['min_amount_for_free_shipping'];
    status = json['status'];
    delivery = json['delivery'];
    sId = json['_id'];
    name = json['name'];
    model = json['model'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subcategory = json['subcategory'];
    manufacturer = json['manufacturer'];
    quantity = json['quantity'];
    description = json['description'];
    if (json['variant'] != null) {
      variant = new List<Variant>();
      json['variant'].forEach((v) {
        variant.add(new Variant.fromJson(v));
      });
    }
    vendorId = json['vendor_id'] != null
        ? new VendorId.fromJson(json['vendor_id'])
        : null;
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['tax'] = this.tax;
    data['image'] = this.image;
    data['shipping'] = this.shipping;
    data['min_amount_for_free_shipping'] = this.minAmountForFreeShipping;
    data['status'] = this.status;
    data['delivery'] = this.delivery;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['model'] = this.model;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['subcategory'] = this.subcategory;
    data['manufacturer'] = this.manufacturer;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    if (this.variant != null) {
      data['variant'] = this.variant.map((v) => v.toJson()).toList();
    }
    if (this.vendorId != null) {
      data['vendor_id'] = this.vendorId.toJson();
    }
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

class Variant {
  List<VariantProperties> variantProperties;
  String sId;
  int price;
  int actualPrice;
  int stock;

  Variant(
      {this.variantProperties,
        this.sId,
        this.price,
        this.actualPrice,
        this.stock});

  Variant.fromJson(Map<String, dynamic> json) {
    if (json['variant_properties'] != null) {
      variantProperties = new List<VariantProperties>();
      json['variant_properties'].forEach((v) {
        variantProperties.add(new VariantProperties.fromJson(v));
      });
    }
    sId = json['_id'];
    price = json['price'];
    actualPrice = json['actual_price'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.variantProperties != null) {
      data['variant_properties'] =
          this.variantProperties.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['price'] = this.price;
    data['actual_price'] = this.actualPrice;
    data['stock'] = this.stock;
    return data;
  }
}

class VariantProperties {
  String sId;
  String variantType;
  String variantValue;
  String variantClass;

  VariantProperties(
      {this.sId, this.variantType, this.variantValue, this.variantClass});

  VariantProperties.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    variantType = json['variant_type'];
    variantValue = json['variant_value'];
    variantClass = json['variant_class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['variant_type'] = this.variantType;
    data['variant_value'] = this.variantValue;
    data['variant_class'] = this.variantClass;
    return data;
  }
}

class VendorId {
  String sId;
  String name;

  VendorId({this.sId, this.name});

  VendorId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
