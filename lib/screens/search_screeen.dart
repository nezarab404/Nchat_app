import 'package:chat_app/constants/Info.dart';
import 'package:chat_app/constants/colors.dart';
import 'package:chat_app/screens/conversation_screen.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _search = TextEditingController();

  DataBaseMethods dataBaseMethods = DataBaseMethods();

  QuerySnapshot searchSnapshot;

  Widget getSearchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchTail(
                userEmail: searchSnapshot.docs[index]['email'],
                userName: searchSnapshot.docs[index]['name'],
              );
            })
        : Container(
            
          );
  }

  /// Create chat room ,send user to conversation screen , pushReplacement
  
  createMyChatRoom(String userName){
    if (userName!=Info.myName) {
      String chatRoomId =getChatRoomId(userName,Info.myName);
      List<String> users=[userName,Info.myName];
      Map<String,dynamic> chatRoomMap ={
        "users":users,
        "chatroomId" : chatRoomId
      };
      dataBaseMethods.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ConversationScreen(chatRoomId,userName)));
    }else print("you can't chat yourself");
  }

  getChatRoomId(String a,String b){
    if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0))
      return "$b\_$a";
    return "$a\_$b";
  }

  Widget searchTail({userName,userEmail}){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(color: Colors.black, width: 5),
          ),
          borderRadius: BorderRadius.circular(40)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              userEmail,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            createMyChatRoom(userName);
          },
          child: Text("message"),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ), 
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text(
          "search for username",
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
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: getTextField(context,"Search", "Enter username to search",
                          Icons.search, _search, (_) {}),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () {
                          dataBaseMethods
                              .getUserByUsename(_search.text)
                              .then((val) {
                            print("%%%%%%%%%% $val %%%%%%%%%%%");
                            setState(() {
                              searchSnapshot = val;
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
                getSearchList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SearchTail extends StatelessWidget {
//   final String userName;
//   final String userEmail;

//   SearchTail({this.userName, this.userEmail});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//       decoration: BoxDecoration(
//           border: Border.fromBorderSide(
//             BorderSide(color: Colors.black, width: 5),
//           ),
//           borderRadius: BorderRadius.circular(40)),
//       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               userName,
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//             ),
//             Text(
//               userEmail,
//               style: TextStyle(color: Colors.white, fontSize: 14),
//             ),
//           ],
//         ),
//         ElevatedButton(
//           onPressed: () {
//             createMyChatRoom(userName);
//           },
//           child: Text("message"),
//           style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30.0),
//             ),
//           ), 
//         )
//       ]),
//     );
//   }
// }
