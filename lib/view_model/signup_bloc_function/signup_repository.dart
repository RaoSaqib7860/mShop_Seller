import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mShop_Seller/view_model/signup_bloc_function/signup_bloc.dart';
import 'package:mShop_Seller/view_model/signup_bloc_function/signup_bloc_states.dart';

class SignupRepository {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  bool loading = false;
  SignUpBloc signUpBloc = SignUpBloc(SignUpInitialState());

  Future<File> getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    File file = File(image!.path);
    return file;
  }

  String selected_imoji_flag = '🇦🇪';
  String seelected_phone = '971';
  final formKey = GlobalKey<FormState>();

}
