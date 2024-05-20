import 'package:flutter/material.dart';

class Helper {
  static String adminUid = "JqdFJap7W1dVBawByda0k7m0iZj2";
  static String adminEmail = "admin@gmail.com";

 static showCustomeNoti(
    context,
    String message,
    bool isSuccess
  ) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message),backgroundColor: isSuccess?Colors.green:Colors.red,),);
  }
}
