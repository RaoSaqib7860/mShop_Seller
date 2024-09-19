import 'package:flutter/material.dart';
abstract class resetPasswordConfirmedScreenEvents{
  const resetPasswordConfirmedScreenEvents();

}
class resetPasswordConfirmedEvent extends resetPasswordConfirmedScreenEvents{
  String? userId;
  String? password;
  String? confirmed_password;
  String? number;
  BuildContext? context;
  resetPasswordConfirmedEvent({this.userId,this.password,this.confirmed_password,this.number,this.context});

}