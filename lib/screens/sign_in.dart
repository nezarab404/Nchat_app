import 'package:chat_app/helper/sharedPreferencesHelper.dart';
import 'package:chat_app/helper/validator.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/widgets.dart';
import 'package:chat_app/constants/colors.dart';
import 'chat_room.dart';
import 'sign_up.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool passwordVisible = true;
  bool isLoading = false;
  IconData i = Icons.visibility_off;
  AuthMethods authMethods = AuthMethods();
  DataBaseMethods dataBaseMethods = DataBaseMethods();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  QuerySnapshot snapshot;


  signMeIn() {
    if (formKey.currentState.validate()) {
      ShPHelper.saveUserEmailShP(_email.text);
      setState(() {
        isLoading = true;
      });
      dataBaseMethods.getUserByUserEmail(_email.text).then((val) {
        snapshot = val;
        ShPHelper.saveUserNameShP(snapshot.docs[0]['name']);
      });

      authMethods
          .signInWithEmailAndPassword(_email.text, _password.text)
          .then((value) => {
                print(value),
                ShPHelper.saveUserLoggedInShP(true),
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => ChatRoom())),
              })
          .onError((error, stackTrace) => showDialog(
              context: context,
              builder: (ctx) => dialog(
                  context: ctx,
                  title: "error",
                  content: "your email or password is not correct")));
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
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: MediaQuery.of(context).size.height - 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Wellcome to Nchat",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Sign In",
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
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          print("Forget Password?");
                          if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(_email.text))
                            showDialog(
                                context: context,
                                builder: (ctx) => dialog(
                                    context: ctx,
                                    title: "Reset Password",
                                    content:
                                        "Check your inbox to reset password"));
                          else
                            showDialog(
                                context: context,
                                builder: (ctx) => dialog(
                                    context: ctx,
                                    title: "Wait",
                                    content: "please enter your Email first"));
                          authMethods.resetPassword(_email.text);
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: 15),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      getButton(
                          "Sign in",
                          Colors.white,
                          [Colors.blue, Colors.lightBlueAccent],
                          signMeIn,
                          context),
                      SizedBox(height: 20),
                      // getButton("Sign in with Google", Colors.black,
                      //     [Colors.white, Colors.white], signMeIn, context),
                      // SizedBox(height: 15),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Register now");
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SignUp()));
                                //Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SignUp()));
                              },
                              child: Text(
                                "Register now",
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
        validator: (val) => Validator.passwordValidator(val),
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
              setState(
                () {
                  passwordVisible = !passwordVisible;
                  i == Icons.visibility_off
                      ? i = Icons.visibility
                      : i = Icons.visibility_off;
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
