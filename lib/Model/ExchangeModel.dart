class ExchangeModel {
  late int id;
  late String name;
  late String code;
  late String country;
  late String currency;
  late String image;

  ExchangeModel(
      this.id,
      this.name,
      this.code,
      this.country,
      this.currency,
      this.image,
      );

  ExchangeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    country = json['country'];
    currency = json['currency'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['country'] = this.country;
    data['currency'] = this.currency;
    data['image'] = this.image;
    return data;
  }
}

class ExchangeProvider{
  List<ExchangeModel> list;

  ExchangeProvider(this.list);

  List<ExchangeModel> getData(){
    return list.where((element) => element.currency == "Unknown").toList();
  }
}