class SelectAddressModel {
  List<Data> data;
  bool success;

  SelectAddressModel({this.data, this.success});

  SelectAddressModel.fromJson(Map<String, dynamic> json) {
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
  String country;
  String sId;
  CustomerId customerId;
  String type;
  String fullName;
  String email;
  int phone;
  String state;
  String city;
  int postcode;
  String address;
  String dateAdded;
  String dateModified;
  int iV;

  Data(
      {this.country,
        this.sId,
        this.customerId,
        this.type,
        this.fullName,
        this.email,
        this.phone,
        this.state,
        this.city,
        this.postcode,
        this.address,
        this.dateAdded,
        this.dateModified,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    sId = json['_id'];
    customerId = json['customer_id'] != null
        ? new CustomerId.fromJson(json['customer_id'])
        : null;
    type = json['type'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    state = json['state'];
    city = json['city'];
    postcode = json['postcode'];
    address = json['address'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['_id'] = this.sId;
    if (this.customerId != null) {
      data['customer_id'] = this.customerId.toJson();
    }
    data['type'] = this.type;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['state'] = this.state;
    data['city'] = this.city;
    data['postcode'] = this.postcode;
    data['address'] = this.address;
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
