import 'package:shared_preferences/shared_preferences.dart';

class ShPHelper{
  static String shPIsLoggedInKey = "ISLOGGEDIN";
  static String shPUserNameKey = "USERNAMEKEY";
  static String shPUserEmailKey = "USEREMAILKEY";


/*Saving Data*/ 
 static Future<bool> saveUserLoggedInShP(bool isLoggedIn)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(shPIsLoggedInKey, isLoggedIn);
  }

 static Future<bool> saveUserNameShP(String userName)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(shPUserNameKey, userName);
  }

 static Future<bool> saveUserEmailShP(String userEmail)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(shPUserEmailKey, userEmail);
  }

/* Getting Data*/
static Future<bool> getUserLoggedInShP()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getBool(shPIsLoggedInKey);
  }

 static Future<String> getUserNameShP()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(shPUserNameKey);
  }

 static Future<String> getUserEmailShP()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(shPUserEmailKey);
  }
 

}