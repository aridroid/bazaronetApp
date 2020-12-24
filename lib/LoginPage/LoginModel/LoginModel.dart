class LoginModel {
  bool loggedin;
  String sId;
  String email;
  String name;
  String phone;
  String token;

  LoginModel(
      {this.loggedin, this.sId, this.email, this.name, this.phone, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    loggedin = json['loggedin'];
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loggedin'] = this.loggedin;
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['token'] = this.token;
    return data;
  }
}
