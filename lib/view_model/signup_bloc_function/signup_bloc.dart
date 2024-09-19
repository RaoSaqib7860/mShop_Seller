import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mShop_Seller/view_model/signup_bloc_function/signup_bloc_events.dart';
import 'package:mShop_Seller/view_model/signup_bloc_function/signup_bloc_states.dart';

import '../../api_repo/api_utils.dart';
import '../../view/screens/LoginPages/otp_screen.dart';

class SignUpBloc extends Bloc<SignUpScreenEvents, SignUpScreenState> {
  bool? response;
  DataProvider dataProvider = DataProvider();

  SignUpBloc(super.initialState) {
    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoadingState());
      response = await dataProvider.signUpFunction(
          Email: event.email,
          Password: event.password,
          phone: event.phone,
          confirmPassword: event.confirmPassword,
          context: event.context,
          shopName: event.shop_name,
          name: event.name);
      if (response == true) {
        Navigator.push(
            event.context!,
            MaterialPageRoute(
              builder: (context) => OtpScreens(
                password: event.password,
                email: event.email,
                number: event.phone,
              ),
            ));
        emit(SignUpLoadedState(response: response));
      } else {
        emit(SignUpErrorState(error: 'error from api '));
      }
    });
  }
}
