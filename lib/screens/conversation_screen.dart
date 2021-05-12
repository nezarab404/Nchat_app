import 'package:chat_app/constants/Info.dart';
import 'package:chat_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  final String partnerName;
  ConversationScreen(this.chatRoomId, this.partnerName);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController _message = TextEditingController();
  DataBaseMethods dataBaseMethods = DataBaseMethods();
  Stream chatMessagesStream;
  var lastTime;

  sendMessage() {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messagesMap = {
        "sendBy": Info.myName,
        "message": _message.text,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      dataBaseMethods.addConversationsMessages(widget.chatRoomId, messagesMap);
      _message.text = "";
    }
  }

  @override
  void initState() {
    print("chatroomid: ${widget.chatRoomId}");
    dataBaseMethods.getConversationsMessages(widget.chatRoomId).then((val) {
      setState(() {
        chatMessagesStream = val;
      });
    });

    super.initState();
  }

  Widget chatMessagesList() {
    return StreamBuilder(
        stream: chatMessagesStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return MessageTail(
                        snapshot.data.docs[index]["message"],
                        snapshot.data.docs[index]["sendBy"] == Info.myName,
                        snapshot.data.docs[index]["time"]);
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.partnerName,
          style: TextStyle(
              color: useWhiteForeground(Theme.of(context).primaryColor)
                  ? Colors.white
                  : Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: chatMessagesList(),
                ),
              ),
              getBottomSheet(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBottomSheet() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.5),
        border: Border.fromBorderSide(
          BorderSide(color: Colors.black, width: 3),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      height: 70,
      padding: EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.fromBorderSide(
                  BorderSide(color: Theme.of(context).primaryColor, width: 2),
                ),
              ),
              child: TextField(
                controller: _message,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "type your message...",
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.fromBorderSide(
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.black,
              ),
              onPressed: () {
                sendMessage();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTail extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  final time;
  var x;

  MessageTail(this.message, this.isSendByMe, this.time) {
    x = DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(time));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSendByMe
              ? Colors.grey.withOpacity(0.5)
              : Theme.of(context).primaryColor.withOpacity(0.9),
          borderRadius: isSendByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                  bottomLeft: Radius.circular(26),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(26),
                  topLeft: Radius.circular(26),
                  bottomRight: Radius.circular(26),
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              isSendByMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: TextStyle(
                  fontSize: 14,
                  color: isSendByMe ? Colors.black : Colors.white),
            ),
            SizedBox(height: 5),
            Text(
              "$x",
              style: TextStyle(
                  fontSize: 9, color: isSendByMe ? Colors.black : Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
