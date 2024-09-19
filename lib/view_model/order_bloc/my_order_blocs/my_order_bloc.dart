import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mShop_Seller/model/order/my_order_model.dart';

import '../../../api_repo/api_utils.dart';
import 'my_order_event.dart';
import 'my_order_state.dart';

class MyOrdersBloc extends Bloc<MyOrdersEvents, MyOrdersStates> {
  DataProvider dataProvider = DataProvider();

  MyOrdersBloc(super.initialState) {
    on<MyOrdersEvent>((event, emit) async {
      emit(MyOrdersLoadingState());
      MyOrderModel response = await dataProvider.myOrderFunction(
          page: '1',
          status: 'pending,confirmed,picked_up,on_the_way',
          count: '20');
      MyOrderModel response_delivered = await dataProvider.myOrderFunction(
          page: '1', status: 'delivered', count: '20');
      MyOrderModel response_cancel = await dataProvider.myOrderFunction(
          page: '1', status: 'cancelled', count: '20');
      if (response != -1) {
        emit(MyOrdersLoadedState(
            response: response,
            response_cancelled: response_cancel,
            response_delivered: response_delivered));
      } else {
        emit(MyOrdersErrorState(error: 'Invalid Data'));
      }
    });
  }
}
