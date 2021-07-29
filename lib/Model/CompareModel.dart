import 'package:intl/intl.dart';

class CompareModel {
  late DateTime date;
  late double open;
  late double high;
  late double low;
  late double close;
  late double adjustedClose;
  late int volume;

  CompareModel(
      this.date,
      this.open,
      this.high,
      this.low,
      this.close,this.adjustedClose, this.volume);

  CompareModel.fromJson(Map<String, dynamic> json) {
    date = DateFormat('yyyy-MM-dd\'T\'hh:mm:ss').parse(json['date']);
    open = json['open'].toDouble();
    high = json['high'].toDouble();
    low = json['low'].toDouble();
    close = json['close'].toDouble();
    try {
      adjustedClose = json['adjustedClose'].toDouble();
    }catch(e){
      adjustedClose = 0.0;
    }
    volume = json['volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['open'] = this.open;
    data['high'] = this.high;
    data['low'] = this.low;
    data['close'] = this.close;
    data['adjustedClose'] = this.adjustedClose;
    data['volume'] = this.volume;
    return data;
  }
}
