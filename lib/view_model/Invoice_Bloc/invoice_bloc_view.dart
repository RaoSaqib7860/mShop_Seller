import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mShop_Seller/model/order/my_order_model.dart';

import '../../../api_repo/api_utils.dart';
import '../../model/Invoice/invoice_model.dart';
import 'invoice_bloc_events.dart';
import 'invoice_bloc_states.dart';

class MyInvoiceBloc extends Bloc<MyInvoiceEvents, MyInvoiceStates> {
  DataProvider dataProvider = DataProvider();

  MyInvoiceBloc(super.initialState) {
    on<MyInvoiceEvent>((event, emit) async {
      emit(MyInvoiceLoadingState());
      invoiceModelView? response = await dataProvider.viewInvoiceFunction(
          count: event.count, page: event.page);
      if (response != null) {
        emit(MyInvoiceLoadedState(
          response: response,
        ));
      } else {
        emit(MyInvoiceErrorState(error: 'Invalid Data'));
      }
    });
  }
}
