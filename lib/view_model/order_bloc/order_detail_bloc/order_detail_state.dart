import '../../../model/order/order_detail_model.dart';

abstract class OrdersDetailStates {}

class OrdersDetailInitialState extends OrdersDetailStates {}

class OrdersDetailLoadingState extends OrdersDetailStates {}

class OrdersDetailLoadedState extends OrdersDetailStates {
  OrderDetailModel response;
  OrdersDetailLoadedState({required this.response});
}

class OrdersDetailErrorState extends OrdersDetailStates {
  String error;
  OrdersDetailErrorState({required this.error});
}
