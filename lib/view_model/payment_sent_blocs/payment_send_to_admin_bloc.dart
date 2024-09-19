import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mShop_Seller/view_model/payment_sent_blocs/payment_send_to_admin_events.dart';
import 'package:mShop_Seller/view_model/payment_sent_blocs/payment_send_to_admin_state.dart';

import '../../../api_repo/api_utils.dart';
import '../../model/payment_sent_to_admin/payment_sent_to_admin_model.dart';

class MyPaymentSendToAdminBloc
    extends Bloc<MyPaymentSendToAdminEvents, MyPaymentSendToAdminStates> {
  DataProvider dataProvider = DataProvider();
  MyPaymentSendToAdminBloc(super.initialState) {
    on<MyPaymentSendToAdminEvent>((event, emit) async {
      emit(MyPaymentSendToAdminLoadingState());
      PaymentSentModel? response = await dataProvider.paymentToAdminFunction(count: event.count,page: event.page);
      if (response != null) {
        emit(MyPaymentSendToAdminLoadedState(response: response));
      } else {
        emit(MyPaymentSendToAdminErrorState(error: 'No Data'));
      }
    });
  }
}
