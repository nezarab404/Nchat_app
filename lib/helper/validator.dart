// import 'package:chat_app/services/database.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Validator {
  // static  _checkIfEmailFound(String val) {
  //   QuerySnapshot querySnapshot;
  //    DataBaseMethods().getUserByUserEmail(val).then((value) {
  //     querySnapshot = value;
  //   });
  //   return querySnapshot.docs.length != 0;
  // }

  static  emailValidator(String val) {
    // if (RegExp(
    //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //     .hasMatch(val)) {
    //   if (_checkIfEmailFound(val)) {
    //     return "this email has used before";
    //   }
    //   return null;
    // } else {
    //   return "this email is not correct";
    // }

    return val==""?"please enter an email"
        :RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(val) ?null
        : "this email is not correct";
  }

  // static singInEmailValidator(String val) {
  //   if (RegExp(
  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //       .hasMatch(val)) {
  //     if (!_checkIfEmailFound(val)) {
  //       return "this email hasn't used before";
  //     }
  //     return null;
  //   } else {
  //     return "this email is not correct";
  //   }
  // }
  // static  _checkIfUsernameNotFound(String val) {
  //   QuerySnapshot querySnapshot;
  //    DataBaseMethods().getUserByUsename(val).then((value) {
  //     querySnapshot = value;
  //   });
  //   return querySnapshot.docs.length == 0;
  // }

  static usernameValidator(String val) {
    // if (val.isEmpty || val.length < 3) {
    //   return "username should be 3 characters at least";
    // } else if (_checkIfUsernameNotFound(val)) {
    //   return null;
    // } else {
    //   return "this username is used before";
    // }
    return val.isEmpty ?"please enter a username": val.length < 3
        ? "3 characters at least"
        : null;
  }

  static passwordValidator(String val) {
    return val.isEmpty?"please enter a password":val.length > 6 ? null : "7 characters at least";
  }
}
