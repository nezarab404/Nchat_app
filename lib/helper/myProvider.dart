import 'package:chat_app/helper/sharedPreferencesHelper.dart';
import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier{
  ThemeMode tm = ThemeMode.light;
  bool swVal = false;
  bool isLoggedIn = false;

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

   getLoggingInState() async {
    await ShPHelper.getUserLoggedInShP().then((value) => {
          print("koko sh p value $value"),
          value != null ? isLoggedIn = value : isLoggedIn = false
        });
    notifyListeners();
    
  }
}