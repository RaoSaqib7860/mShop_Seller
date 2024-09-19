

import '../../../model/add_to_cart_model/add_to_cart_list.dart';
import '../../../model/add_to_cart_model/add_to_cart_summary_model.dart';


abstract class AddToCartStates{

}

class AddToCartInitialState extends AddToCartStates{

}
class AddToCartLoadingState extends AddToCartStates{

}
class AddToCartLoadedState extends AddToCartStates{

  AddToCartLoadedState();
}
class AddToCartErrorState extends AddToCartStates{
  String error;
  AddToCartErrorState({required this.error});
}