import 'package:chat_app/constants/Info.dart';
import 'package:chat_app/helper/sharedPreferencesHelper.dart';
import 'package:chat_app/screens/search_screeen.dart';
import 'package:chat_app/screens/sign_in.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:flutter/material.dart';
import 'conversation_screen.dart';
import 'info_screen.dart';

const String url =
    "https://cdn4.vectorstock.com/i/1000x1000/75/33/flat-style-character-avatar-icon-vector-19367533.jpg";

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  DataBaseMethods dataBaseMethods = DataBaseMethods();
  Stream chatRoomStream;
  var myImage = Image.network(url);

  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatRoomStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 16, left: 10, right: 10),
                      decoration: BoxDecoration(
                          border: Border.fromBorderSide(
                            BorderSide(color: Colors.black, width: 2),
                          ),
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ConversationScreen(
                                snapshot.data.docs[index]["chatroomId"],
                                snapshot.data.docs[index]["chatroomId"]
                                    .toString()
                                    .replaceAll("_", "")
                                    .replaceAll(Info.myName, ""),
                              ),
                            ),
                          );
                        },
                        title: Text(
                          snapshot.data.docs[index]["chatroomId"]
                              .toString()
                              .replaceAll("_", "")
                              .replaceAll(Info.myName, ""),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            snapshot.data.docs[index]["chatroomId"]
                                .toString()
                                .replaceAll("_", "")
                                .replaceAll(Info.myName, "")
                                .substring(0, 1)
                                .toUpperCase(),
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Info.myName = await ShPHelper.getUserNameShP();
    Info.myEmail = await ShPHelper.getUserEmailShP();
    setState(() {
      dataBaseMethods.getChatRooms(Info.myName).then((val) {
        chatRoomStream = val;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${Info.myName}"),
        leading: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
          child: InkWell(
            onTap: () {
              print("koko");
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => UserInfo(url)));
            }, //TODO

            child: Hero(
              tag: url,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(url),
              ),
            ),
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.person_add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SearchScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: Text(
                          "LogOut",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("are you sure to logout ?"),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      AuthMethods().signOut();
                                      ShPHelper.saveUserLoggedInShP(false);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => SignIn(),
                                        ),
                                      );
                                    },
                                    child: Text("logout")),
                                ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("close"))
                              ],
                            )
                          ],
                        ),
                      ));
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              "Chats",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: chatRoomList(),
            ),
          ),
        ],
      ),
    );
  }
}
