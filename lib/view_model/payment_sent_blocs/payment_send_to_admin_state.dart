import '../../../model/order/my_order_model.dart';
import '../../model/commission_history/commission_history_model.dart';
import '../../model/payment_sent_to_admin/payment_sent_to_admin_model.dart';

abstract class MyPaymentSendToAdminStates{

}

class MyPaymentSendToAdminInitialState extends MyPaymentSendToAdminStates{

}
class MyPaymentSendToAdminLoadingState extends MyPaymentSendToAdminStates{

}
class MyPaymentSendToAdminLoadedState extends MyPaymentSendToAdminStates{
  PaymentSentModel response;
  MyPaymentSendToAdminLoadedState({required this.response});
}
class MyPaymentSendToAdminErrorState extends MyPaymentSendToAdminStates{
  String error;
  MyPaymentSendToAdminErrorState({required this.error});
}