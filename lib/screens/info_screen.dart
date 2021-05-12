import 'package:chat_app/constants/Info.dart';
import 'package:chat_app/helper/myProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class UserInfo extends StatefulWidget {
  final herotag;

  const UserInfo(this.herotag);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  Color _color = Colors.purple;
  // void changeColor(Color color)=>setState(()=>_color=color);

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
                color: useWhiteForeground(Theme.of(context).primaryColor)
                    ? Colors.white
                    : Colors.black,
              ),
              onPressed: () => Navigator.pop(context)),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: useWhiteForeground(Theme.of(context).primaryColor)
                      ? Colors.white
                      : Colors.black,
                ),
                onPressed: () {})
          ],
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
                            color: useWhiteForeground(
                                    Theme.of(context).primaryColor)
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ListView(
                      padding: EdgeInsets.only(top: 0),
                      children: [
                        ListTile(
                          title: Text("Dark Mode"),
                          trailing: Switch(
                            value: Provider.of<MyProvider>(context).swVal,
                            onChanged: (bool val) =>
                                Provider.of<MyProvider>(context, listen: false)
                                    .switchChange(val),
                            activeColor: Theme.of(context).primaryColor,
                            inactiveThumbColor: Colors.black,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          title: Text("Change Color"),
                          trailing: CircleAvatar(
                            backgroundColor:
                                Provider.of<MyProvider>(context, listen: false)
                                    .prColor,
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SingleChildScrollView(
                                          child: BlockPicker(
                                            pickerColor:
                                                Provider.of<MyProvider>(context,
                                                        listen: false)
                                                    .prColor,
                                            onColorChanged: (color) =>
                                                Provider.of<MyProvider>(context,
                                                        listen: false)
                                                    .changeColor(color),
                                          ),
                                        ),
                                        ElevatedButton(
                                          child: Text("close"),
                                          onPressed: () => Navigator.pop(ctx),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          title: Text("koko"),
                          onTap: () {},
                        ),
                        Divider(
                          thickness: 2,
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
