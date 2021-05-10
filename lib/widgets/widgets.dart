import 'package:flutter/material.dart';

import 'package:chat_app/constants/colors.dart';

Widget myAppBar(BuildContext context) {
  return AppBar();
}

Widget getTextField(context,String lable, String hint, IconData icon, controler,
    Function(String) valid) {
  return Container(
    margin: EdgeInsets.only(right: 15, left: 15),
    padding: EdgeInsets.only(left: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColor,width:2),),
    ),
    child: TextFormField(
      validator: (val) => valid(val),
      
      controller: controler,
      keyboardType:
          lable == "Email" ? TextInputType.emailAddress : TextInputType.name,
      decoration: InputDecoration(
        labelText: lable,
        border: InputBorder.none,
        hintText: hint,
        icon: Icon(icon),
        hintStyle: TextStyle(fontSize: lable == "Search"?12:14),
      ),
      
    ),
  );
}

Widget getButton(
    String text, Color fontColor, List<Color> colorslist, Function fun,
    [context]) {
  return GestureDetector(
    onTap: () {
      fun();
      debugPrint("click");
    },
    child: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 15, right: 15),
      padding: EdgeInsets.only(top: 12, bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: colorslist),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fontColor,
          fontSize: 20,
        ),
      ),
    ),
  );
}

dialog({BuildContext context, String title, String content}) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(content),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () => Navigator.pop(context), child: Text("close"))
        ],
      ),
    );
  }
