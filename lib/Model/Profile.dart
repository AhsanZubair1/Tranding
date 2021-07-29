class ProfileModel {
  Res ?res;

  ProfileModel({this.res});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    res = json['res'] != null ? new Res.fromJson(json['res']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.res != null) {
      data['res'] = this.res?.toJson();
    }
    return data;
  }
}

class Res {
  int? id;
  String? uniqueId;
  String? name;
  String? email;
  String? loginFrom;
  String? phoneNo;
  String? reffralCode;
  String? password;
  String? image;
  String? country;
  bool? isActive;

  Res(
      {required this.id,
        required this.uniqueId,
        required this.name,
        this.email,
        required this.loginFrom,
        this.phoneNo,
        required this.reffralCode,
        required this.password,
        this.image,
        required this.country,
        required this.isActive});

  Res.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['uniqueId'];
    name = json['name'];
    email = json['email'];
    loginFrom = json['loginFrom'];
    phoneNo = json['phoneNo'];
    reffralCode = json['reffralCode'];
    password = json['password'];
    image = json['image'];
    country = json['country'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uniqueId'] = this.uniqueId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['loginFrom'] = this.loginFrom;
    data['phoneNo'] = this.phoneNo;
    data['reffralCode'] = this.reffralCode;
    data['password'] = this.password;
    data['image'] = this.image;
    data['country'] = this.country;
    data['isActive'] = this.isActive;
    return data;
  }
}