class TrendingModel {
  late int id;
  late String code;
  late int timestamp;
  late int gmtoffset;
  late double open;
  late double high;
  late double low;
  late double close;
  late double volume;
  late double previousClose;
  late double change;
  late double changeP;

  TrendingModel(
      {
        required this.id,
        required this.code,
        required this.timestamp,
        required this.gmtoffset,
        required this.open,
        required this.high,
        required this.low,
        required this.close,
        required this.volume,
        required this.previousClose,
        required this.change,
        required this.changeP
      }
      );

  TrendingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    timestamp = json['timestamp'];
    gmtoffset = json['gmtoffset'];
    open = json['open'].toDouble();
    high = json['high'].toDouble();
    low = json['low'].toDouble();
    close = json['close'].toDouble();
    volume = json['volume'].toDouble();
    previousClose = json['previousClose'];
    change = (json['change']).toDouble();

    try{
      changeP = (json['changeP']).toDouble();
    }catch(e){
      changeP = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['timestamp'] = this.timestamp;
    data['gmtoffset'] = this.gmtoffset;
    data['open'] = this.open;
    data['high'] = this.high;
    data['low'] = this.low;
    data['close'] = this.close;
    data['volume'] = this.volume;
    data['previousClose'] = this.previousClose;
    data['change'] = this.change;
    data['changeP'] = this.changeP;
    return data;
  }
}
class TrendingHelper{
  String? code;
  List<double> clist = [];
  List<TrendingModel> list = [];

  TrendingHelper();
}

class TrendingHelper2{
  int res = 0;
  List<TrendingModel> list = [];

  TrendingHelper2();
}