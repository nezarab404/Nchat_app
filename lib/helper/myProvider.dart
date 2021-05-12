import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier{
  ThemeMode tm = ThemeMode.light;
  bool swVal = false;
  Color prColor = Colors.blueAccent;

  void switchChange(bool val){
    swVal = val;
    if(swVal==false){
      tm=ThemeMode.light;
      print("$tm");
    }
    else{
      tm=ThemeMode.dark;
      print("$tm");
    }
    notifyListeners();
  }

  void changeColor(Color color){
    prColor=color;
    notifyListeners();
  }

}