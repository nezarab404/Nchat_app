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
        themeMode: ThemeMode.dark,
        home: ChangeNotifierProvider<MyProvider>(
          create: (_) => MyProvider(),
          child: MyApp(),
        ));
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    isLoggedIn = false;
    getLoggingInState();
    super.initState();
  }

  getLoggingInState() async {
    await ShPHelper.getUserLoggedInShP().then((value) => {
          print("koko sh p value $value"),
          value != null ? isLoggedIn = value : isLoggedIn = false
        });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    print(pro.tm);
    return MaterialApp(
      title: 'Nchat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: pro.prColor,
        dividerColor: Colors.black.withOpacity(0.2),
        fontFamily: "KiwiMaru",
      ),
      darkTheme: ThemeData(
        primaryColor: pro.prColor,
        dividerColor: Colors.white30,
        dialogTheme: DialogTheme(
          titleTextStyle: TextStyle(
              color: Colors.white, fontFamily: "KiwiMaru", fontSize: 22),
          backgroundColor: Colors.grey[800],
        ),
        textTheme: TextTheme(
          subtitle1: TextStyle(color: Colors.white),
        ),
        canvasColor: Colors.grey[850],
        fontFamily: "KiwiMaru",
      ),
      themeMode: pro.tm,
      home: isLoggedIn ? ChatRoom() : SignUp(),
    );
  }
}
