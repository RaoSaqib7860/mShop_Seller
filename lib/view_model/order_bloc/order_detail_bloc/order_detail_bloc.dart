import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api_repo/api_utils.dart';
import '../../../model/order/order_detail_model.dart';
import '../../../view/screens/orders/repository_orders.dart';
import 'order_detail_event.dart';
import 'order_detail_state.dart';

class OrdersDetailBloc extends Bloc<OrdersDetailEvents, OrdersDetailStates>
    with orderDetailRepository {
  DataProvider dataProvider = DataProvider();

  OrdersDetailBloc(super.initialState) {
    on<OrdersDetailEvent>((event, emit) async {
      emit(OrdersDetailLoadingState());
      OrderDetailModel response =
          await DataProvider.orderDetailFunction(event.Id!);
      print('deliveredByHousy ....... ${response.data!.deliveredByHousy}');
      if (response != -1) {
        emit(OrdersDetailLoadedState(response: response));
      } else {
        emit(OrdersDetailErrorState(error: 'Invalid Data'));
      }
    });
  }
}
