import 'package:trade_watch/Model/CurrencyModel.dart';
import 'package:trade_watch/Model/ExchangeModel.dart';

abstract class Compareinterface{
  void func(  int page, List<CurrencyModel> currencyProvider, /*ExchangeProvider exchangeProvider,*/
      List<CurrencyModel> dlist, int dindex, int typeindex, int currindex,
  );
}