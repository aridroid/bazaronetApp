class AddToCartModel {
  Data data;
  bool success;

  AddToCartModel({this.data, this.success});

  AddToCartModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String sId;
  String customerId;
  String product;
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
    customerId = json['customer_id'];
    product = json['product'];
    quantity = json['quantity'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['customer_id'] = this.customerId;
    data['product'] = this.product;
    data['quantity'] = this.quantity;
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['__v'] = this.iV;
    return data;
  }
}
