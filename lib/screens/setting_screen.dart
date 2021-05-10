import 'package:chat_app/constants/colors.dart';
import 'package:chat_app/helper/sharedPreferencesHelper.dart';
import 'package:chat_app/screens/sign_in.dart';
import 'package:chat_app/services/auth.dart';
import 'package:flutter/material.dart';

class SittingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue1,
        title: Text(
          "Setting",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.redAccent,
              Colors.purpleAccent,
              Colors.blueAccent,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  AuthMethods().signOut();
                  ShPHelper.saveUserLoggedInShP(false);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SignIn(),
                    ),
                  );
                }, 
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.only(top: 20),
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: blue1,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      Text("Sign Out",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
