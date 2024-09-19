import 'package:flutter/material.dart';
abstract class ForgotPasswordOtpScreenEvents{
  const ForgotPasswordOtpScreenEvents();

}
class ForgotPasswordOtpEvent extends ForgotPasswordOtpScreenEvents{
  String? phone;
  String? res;
  String? number;
  BuildContext? context;
  ForgotPasswordOtpEvent({this.phone,this.res,this.number,this.context});

}