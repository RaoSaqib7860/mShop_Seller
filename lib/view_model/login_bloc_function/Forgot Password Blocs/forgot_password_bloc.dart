import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api_repo/api_utils.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotBloc extends Bloc<ForgotScreenEvents, ForgotScreenState> {
  bool? response;
  DataProvider dataProvider = DataProvider();
  ForgotBloc(super.initialState) {
    on<ForgotEvent>((event, emit) async {
      emit(ForgotLoadingState());
      response = await dataProvider.forget_request_api(phone: event.phone);
      if (response == true) {
        emit(ForgotLoadedState(response: response));
      } else {
        emit(ForgotInitialState());
      }
    });
  }
}
