import 'package:chat_app/helper/myProvider.dart';
import 'package:chat_app/helper/sharedPreferencesHelper.dart';
import 'package:chat_app/screens/chat_room.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/screens/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // HttpProxy httpProxy = await HttpProxy.createHttpProxy();
  // HttpOverrides.global = httpProxy;
  await Firebase.initializeApp();
  runApp(MyHomeApp());
}

class MyHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<MyProvider>(
      create: (_) => MyProvider(),
      child: MyApp(),
      )
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool isLoggedIn = false;

  // @override
  // void initState() {
  //   isLoggedIn = false;
  //   getLoggingInState();
  //   super.initState();
  // }

  // getLoggingInState() async {
  //   await ShPHelper.getUserLoggedInShP().then((value) => {
  //         print("koko sh p value $value"),
  //         value != null ? isLoggedIn = value : isLoggedIn = false
  //       });
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    
    return 
      MaterialApp(
        title: 'Nchat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
          fontFamily: "KiwiMaru",
        ),
        themeMode: pro.tm,
        home:pro.isLoggedIn ?ChatRoom() : SignUp(),
      
    );
  }
}
