import 'package:flutter/material.dart';

abstract class SignUpScreenEvents {
  const SignUpScreenEvents();
}

class SignUpEvent extends SignUpScreenEvents {
  String? email;
  String? name;
  String? password;
  String? confirmPassword;
  String? phone;
  BuildContext? context;
  String? shop_name;
  SignUpEvent(
      {this.email,
      this.password,
      this.confirmPassword,
      this.name,
      this.phone,
      this.context,
      this.shop_name});
}
