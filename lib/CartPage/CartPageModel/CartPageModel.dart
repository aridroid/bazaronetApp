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
  int quantity;
  Product product;
  String dateAdded;
  String dateModified;
  int iV;

  Data(
      {this.sId,
        this.customerId,
        this.quantity,
        this.product,
        this.dateAdded,
        this.dateModified,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customer_id'] != null
        ? new CustomerId.fromJson(json['customer_id'])
        : null;
    quantity = json['quantity'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
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
    data['quantity'] = this.quantity;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['__v'] = this.iV;
    return data;
  }
}

class CustomerId {
  bool isVerified;
  bool status;
  String sId;
  String email;
  String phone;
  String name;
  String password;
  String role;
  int code;
  String dateAdded;
  String dateModified;
  int iV;

  CustomerId(
      {this.isVerified,
        this.status,
        this.sId,
        this.email,
        this.phone,
        this.name,
        this.password,
        this.role,
        this.code,
        this.dateAdded,
        this.dateModified,
        this.iV});

  CustomerId.fromJson(Map<String, dynamic> json) {
    isVerified = json['isVerified'];
    status = json['status'];
    sId = json['_id'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    password = json['password'];
    role = json['role'];
    code = json['code'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isVerified'] = this.isVerified;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['password'] = this.password;
    data['role'] = this.role;
    data['code'] = this.code;
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['__v'] = this.iV;
    return data;
  }
}

class Product {
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
  int unit;
  int quantity;
  String quantityClass;
  String description;
  Variant variant;
  String dateAdded;
  String dateModified;
  int iV;
  Variant selectedVariant;
  VendorId vendorId;
  String service_date;
  String service_time;

  Product(
      {this.tax,
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
        this.unit,
        this.quantity,
        this.quantityClass,
        this.description,
        this.variant,
        this.dateAdded,
        this.dateModified,
        this.iV,
        this.selectedVariant,
        this.vendorId,
        this.service_date,
        this.service_time
      });

  Product.fromJson(Map<String, dynamic> json) {
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
    unit = json['unit'];
    quantity = json['quantity'];
    quantityClass = json['quantity_class'];
    description = json['description'];
    variant =
    json['variant'] != null ? new Variant.fromJson(json['variant']) : null;
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    iV = json['__v'];
    selectedVariant = json['selectedVariant'] != null
        ? new Variant.fromJson(json['selectedVariant'])
        : null;
    vendorId = json['vendor_id'] != null
        ? new VendorId.fromJson(json['vendor_id'])
        : null;
    service_date = json['service_date'];
    service_time = json['service_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['unit'] = this.unit;
    data['quantity'] = this.quantity;
    data['quantity_class'] = this.quantityClass;
    data['description'] = this.description;
    if (this.variant != null) {
      data['variant'] = this.variant.toJson();
    }
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['__v'] = this.iV;
    if (this.selectedVariant != null) {
      data['selectedVariant'] = this.selectedVariant.toJson();
    }
    if (this.vendorId != null) {
      data['vendor_id'] = this.vendorId.toJson();
    }
    data['service_date']=this.service_date;
    data['service_time']=this.service_time;
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
