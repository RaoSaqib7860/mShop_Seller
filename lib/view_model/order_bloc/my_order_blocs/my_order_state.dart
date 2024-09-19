import '../../../model/order/my_order_model.dart';

abstract class MyOrdersStates {}

class MyOrdersInitialState extends MyOrdersStates {}

class MyOrdersLoadingState extends MyOrdersStates {}

class MyOrdersLoadedState extends MyOrdersStates {
  MyOrderModel response;
  MyOrderModel response_delivered;
  MyOrderModel response_cancelled;
  MyOrdersLoadedState(
      {required this.response,
      required this.response_delivered,
      required this.response_cancelled});
}

class MyOrdersErrorState extends MyOrdersStates {
  String error;
  MyOrdersErrorState({required this.error});
}
