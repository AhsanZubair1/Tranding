import 'package:flutter/cupertino.dart';

class QuestionModel{
  late String question;
  late List<String> answer;

  QuestionModel(this.question, this.answer);
}

class QuestionProvider with ChangeNotifier{
  List<QuestionModel> list = [];

  addItem(QuestionModel model){
    list.add(model);
    notifyListeners();
  }
}

class AnswerProvider with ChangeNotifier{
  List<String> list = [];
  adItem(String s){
    list.add(s);
    try{
      notifyListeners();
    }catch(e){

    }
  }
}