import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_bloc.dart';
import 'login_bloc_states.dart';

class LoginRepository {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  bool showPassword = false;
  LoginBloc loginBloc = LoginBloc(LoginInitialState());
  bool isPasswordShow = false;
  String? validate_email_phone(String? value) {
    if (value!.length < 5) {
      return 'Email or phone must be more than 3 character'.tr;
    } else {
      return null;
    }
  }

  String? validate_password(String? value) {
    if (value!.length < 5) {
      return 'Password must be more than 3 character'.tr;
    } else {
      return null;
    }
  }
}
