import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:mShop_Seller/view_model/login_bloc_function/login_bloc_events.dart';
import 'package:mShop_Seller/view_model/login_bloc_function/login_bloc_states.dart';

import '../../api_repo/api_utils.dart';
import '../../utils_services/global_variable.dart';

class LoginBloc extends Bloc<LoginScreenEvents, LoginScreenState> {
  bool? response;
  DataProvider dataProvider = DataProvider();
  LoginBloc(super.initialState) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      response = await dataProvider.loginFunction(
          Email: event.email, Password: event.password);
      if (response == true) {
        OneSignal.shared
            .setExternalUserId('seller_' + user_model.user!.id.toString());
        emit(LoginLoadedState(response: response));
      } else {
        emit(LoginErrorState(error: 'Invalid credentials'));
      }
    });
  }
}
