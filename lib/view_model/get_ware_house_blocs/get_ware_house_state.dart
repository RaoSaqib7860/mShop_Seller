import '../../model/all_ware_house/all_ware_house_model.dart';
import '../../model/order/ware_house_model.dart';

abstract class MyWareHouseListStates{

}

class MyWareHouseListInitialState extends MyWareHouseListStates{

}
class MyWareHouseListLoadingState extends MyWareHouseListStates{

}
class MyWareHouseListLoadedState extends MyWareHouseListStates{
  allWareHouseModel? response;
  MyWareHouseListLoadedState({required this.response});
}
class MyWareHouseListErrorState extends MyWareHouseListStates{
  String error;
  MyWareHouseListErrorState({required this.error});
}