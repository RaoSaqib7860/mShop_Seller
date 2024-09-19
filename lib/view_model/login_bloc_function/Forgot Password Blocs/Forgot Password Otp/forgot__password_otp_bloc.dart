import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../api_repo/api_utils.dart';
import '../../../../model/password_reset/confirm_reset.dart';
import '../../../../view/screens/LoginPages/password_reset_screen.dart';
import 'forgot__password_otp_event.dart';
import 'forgot__password_otp_state.dart';

class ForgotPasswordOtpBloc
    extends Bloc<ForgotPasswordOtpScreenEvents, ForgotPasswordOtpScreenState> {
  ConfirmReset? response;
  bool? res;
  DataProvider dataProvider = DataProvider();
  ForgotPasswordOtpBloc(super.initialState) {
    on<ForgotPasswordOtpEvent>((event, emit) async {
      emit(ForgotPasswordOtpLoadingState());
      ConfirmReset response =
          await dataProvider.confirm_Otp_rest(sendOtp: event.phone);
      // res = await dataProvider.auth_resend_phone_code(resendCode: event.res);
      if (response.result!) {
        Navigator.push(
            event.context!,
            MaterialPageRoute(
              builder: (context) => PasswordResetScreen(),
            ));
      }
      if (response != null) {
        emit(ForgotPasswordOtpLoadedState(response: response, res: res));
      } else {
        emit(ForgotPasswordOtpErrorState(error: 'error from api '));
      }
    });
  }
}
