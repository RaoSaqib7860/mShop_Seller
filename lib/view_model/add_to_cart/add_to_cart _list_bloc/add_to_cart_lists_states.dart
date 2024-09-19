

import '../../../model/add_to_cart_model/add_to_cart_list.dart';
import '../../../model/add_to_cart_model/add_to_cart_summary_model.dart';


abstract class AddToCartListStates{

}

class AddToCartListInitialState extends AddToCartListStates{

}
class AddToCartListLoadingState extends AddToCartListStates{

}
class AddToCartListLoadedState extends AddToCartListStates{
  AddToCartList response;
  AddToCartSummaryModel res;
  AddToCartListLoadedState({required this.response, required this.res });
}
class AddToCartListErrorState extends AddToCartListStates{
  String error;
  AddToCartListErrorState({required this.error});
}