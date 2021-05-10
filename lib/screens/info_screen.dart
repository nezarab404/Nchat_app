import 'package:chat_app/constants/Info.dart';
import 'package:chat_app/helper/myProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  final herotag;

  const UserInfo(this.herotag);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  var _sval=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () => Navigator.pop(context)),
          actions: [IconButton(icon: Icon(Icons.edit), onPressed: () {})],
        ),
        body: Stack(
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(170),
                    bottomRight: Radius.circular(170)),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 170,
                  padding: EdgeInsets.only(top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        child: Hero(
                          tag: widget.herotag,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.herotag),
                          ),
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        "${Info.myName}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ListView(
                      padding: EdgeInsets.only(top: 0),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("dark mode"),
                              Switch(
                                  value: Provider.of<MyProvider>(context).swVal,
                                  onChanged: (bool val)=>Provider.of<MyProvider>(context,listen:false).switchChange(val),
                                  activeColor: Theme.of(context).primaryColor,
                                  inactiveThumbColor: Colors.pink,
                                ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
