import '../../../model/delivery_model/delivery_model_list.dart';

abstract class DeliveryBoyListScreenState{

}

class DeliveryBoyListInitialState extends DeliveryBoyListScreenState{

}
class DeliveryBoyListLoadingState extends DeliveryBoyListScreenState{

}
class DeliveryBoyListLoadedState extends DeliveryBoyListScreenState{

  DeliveryBoyList res;
  DeliveryBoyListLoadedState({ required this.res});
}
class DeliveryBoyListErrorState extends DeliveryBoyListScreenState{
  String error;
  DeliveryBoyListErrorState({required this.error});
}