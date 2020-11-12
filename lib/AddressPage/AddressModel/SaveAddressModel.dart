class SaveAddressModel {
  String country;
  String sId;
  String customerId;
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

  SaveAddressModel(
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

  SaveAddressModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    sId = json['_id'];
    customerId = json['customer_id'];
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
    data['customer_id'] = this.customerId;
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
