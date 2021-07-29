class ProileModel{
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
ProileModel(
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
}