import 'package:chat_app/helper/sharedPreferencesHelper.dart';
import 'package:chat_app/helper/validator.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/widgets.dart';
import 'package:chat_app/constants/colors.dart';
import 'chat_room.dart';
import 'sign_in.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passwordVisible = true;
  IconData i = Icons.visibility_off;

  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  AuthMethods authMethods = AuthMethods();
  DataBaseMethods dataBaseMethods = DataBaseMethods();

  signMeUp() {
    if (formKey.currentState.validate()) {
      Map<String, String> userMap = {
        "name": _username.text,
        "email": _email.text
      };
      //ShPHelper.saveUserLoggedInShP(true);
      ShPHelper.saveUserNameShP(_username.text);
      ShPHelper.saveUserEmailShP(_email.text);
      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(_email.text, _password.text)
          .then((value) {
        print(value);
        dataBaseMethods.uploadUserInfo(userMap);
        ShPHelper.saveUserLoggedInShP(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => ChatRoom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: myAppBar(context),
      body: isLoading
          ? Container(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.redAccent,
                    Colors.purpleAccent,
                    Colors.blueAccent,
                  ],
                ),
              ),
              alignment: Alignment.center,
              // child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width - 30,
                height: MediaQuery.of(context).size.height - 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(
                   50
                  ),
                ),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                  top: 20,
                  left: 10,
                  bottom: 20
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Wellcome to Nchat",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          
                        ),
                      ),
                      SizedBox(height: 50),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            getTextField(
                                context,
                                "Username",
                                "Enter your username",
                                Icons.person_outline_rounded,
                                _username,
                                Validator.usernameValidator),
                            SizedBox(height: 20),
                            getTextField(
                                context,
                                "Email",
                                "Enter your email",
                                Icons.email_outlined,
                                _email,
                                Validator.emailValidator),
                            SizedBox(height: 20),
                            getPasswordTextField("Password",
                                "Enter your password", Icons.lock, _password),
                          ],
                        ),
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   alignment: Alignment.centerRight,
                      //   padding: EdgeInsets.only(right: 0),
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       print(
                      //           "Forget Password?");
                      //     },
                      //     child: Container(
                      //       height: 40,
                      //       width: 150,
                      //       padding: EdgeInsets.only(right: 15),
                      //       margin: EdgeInsets.only(top: 10),
                      //       alignment: Alignment.centerRight,
                      //       child: Text(
                      //         "Forget Password?",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           decoration: TextDecoration.underline,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 20),
                      getButton(
                          "Sign up",
                          Colors.white,
                          [Colors.blue, Colors.lightBlueAccent],
                          signMeUp,
                          context),
                      SizedBox(height: 20),
                      // getButton("Sign up with Google", Colors.black,
                      //     [Colors.white, Colors.white], signMeUp, context),
                      // SizedBox(height: 15),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "already have an account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Sign in");
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SignIn()));
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

      //),
    );
  }

  Widget getPasswordTextField(
      String lable, String hint, IconData icon, controler) {
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15),
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.fromBorderSide(
          BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
      ),
      child: TextFormField(
        validator: (val)=>Validator.passwordValidator(val),
        controller: controler,
        cursorColor: green1,
        obscureText: passwordVisible,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            labelText: lable,
            border: InputBorder.none,
            hintText: hint,
            icon: Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              iconSize: 20,
              alignment: Alignment.centerLeft,
              icon: Icon(i),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                  i == Icons.visibility_off
                      ? i = Icons.visibility
                      : i = Icons.visibility_off;
                });
              },
            )),
      ),
    );
  }
}
