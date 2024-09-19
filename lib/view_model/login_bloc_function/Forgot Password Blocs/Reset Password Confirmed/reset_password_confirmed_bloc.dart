import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mShop_Seller/view_model/login_bloc_function/Forgot%20Password%20Blocs/Reset%20Password%20Confirmed/reset_password_confirmed_events.dart';
import 'package:mShop_Seller/view_model/login_bloc_function/Forgot%20Password%20Blocs/Reset%20Password%20Confirmed/reset_password_confirmed_states.dart';

import '../../../../api_repo/api_utils.dart';
import '../../../../view/screens/LoginPages/login_screen.dart';

String forgot_user_id = '';

class resetPasswordConfirmedBloc extends Bloc<
    resetPasswordConfirmedScreenEvents, resetPasswordConfirmedScreenState> {
  resetPasswordConfirmedBloc(super.initialState) {
    on<resetPasswordConfirmedEvent>((event, emit) async {
      emit(resetPasswordConfirmedLoadingState());
      bool response = await DataProvider().confirm_reset_password(
          userId: forgot_user_id,
          password: event.password,
          confirmedPassword: event.confirmed_password);
      if (response) {
        // bool result = await DataProvider()
        //     .loginFunction(Email: event.number, Password: event.password);
        // if (result) {
        //   Navigator.pushAndRemoveUntil(
        //     event.context!,
        //     MaterialPageRoute(
        //       builder: (context) => LoginScreen(),
        //     ),
        //     ModalRoute.withName('/'),
        //   );
        // }
        Navigator.pushAndRemoveUntil(
          event.context!,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
          ModalRoute.withName('/'),
        );
      } else {
        emit(resetPasswordConfirmedInitialState());
      }
      if (response == true) {
        emit(resetPasswordConfirmedLoadedState(response: response));
      } else {
        emit(resetPasswordConfirmedErrorState(error: 'error from api '));
      }
    });
  }
}
