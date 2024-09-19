import '../../../model/order/my_order_model.dart';
import '../../model/commission_history/commission_history_model.dart';

abstract class MyCommissionHistoryStates{

}

class MyCommissionHistoryInitialState extends MyCommissionHistoryStates{

}
class MyCommissionHistoryLoadingState extends MyCommissionHistoryStates{

}
class MyCommissionHistoryLoadedState extends MyCommissionHistoryStates{
  CommissionHistory response;
  MyCommissionHistoryLoadedState({required this.response});
}
class MyCommissionHistoryErrorState extends MyCommissionHistoryStates{
  String error;
  MyCommissionHistoryErrorState({required this.error});
}