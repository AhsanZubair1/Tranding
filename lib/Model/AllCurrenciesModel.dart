class AllCurrencyModel {
  late int id;
  late String country;
  late String currency;
  late String iso;

  AllCurrencyModel(this.id, this.country, this.currency, this.iso);

  AllCurrencyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    currency = json['currency'];
    iso = json['iso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country'] = this.country;
    data['currency'] = this.currency;
    data['iso'] = this.iso;
    return data;
  }
}
