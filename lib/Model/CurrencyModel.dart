class CurrencyModel {
  late int id;
  late int exId;
  late String name;
  late String code;
  late String fkCode;
  late String iconName;
  late bool isActive;
  late int fkId;

  CurrencyModel(
      this.id,
        this.exId,
        this.name,
        this.code,
        this.fkCode,
        this.iconName,
        this.isActive,
        this.fkId
      );

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exId = json['exId'];
    name = json['name'];
    code = json['code'];
    fkCode = json['fkCode'];
    iconName = json['iconName'];
    isActive = json['isActive'];
    fkId = json['fkId'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exId'] = this.exId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['fkCode'] = this.fkCode;
    data['iconName'] = this.iconName;
    data['isActive'] = this.isActive;
    data['fkId'] = this.fkId;
    return data;
  }
}



class CurrencyProvider{
  List<CurrencyModel> list;
  CurrencyProvider(this.list);

  List<CurrencyModel> getdata(int exid){
    List<CurrencyModel> lis= list.where((element) => element.exId == exid).toList();
    print(lis.length);
    return lis;
  }


  Future<List<CurrencyModel>> getdataa(int exid){

    List<CurrencyModel> lis= [];
    
    list.forEach((element) {
      if(element.exId == exid){
        lis.add(element);
      }
    });
    return Future.value(lis);
  }
}