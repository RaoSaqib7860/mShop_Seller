import '../../../model/order/my_order_model.dart';
import '../../model/Compaigns/compaign_model.dart';

abstract class MyCompaignsStates{

}

class MyCompaignsInitialState extends MyCompaignsStates{

}
class MyCompaignsLoadingState extends MyCompaignsStates{

}
class MyCompaignsLoadedState extends MyCompaignsStates{
  CompaignModel response;
  MyCompaignsLoadedState({required this.response});
}
class MyCompaignsErrorState extends MyCompaignsStates{
  String error;
  MyCompaignsErrorState({required this.error});
}