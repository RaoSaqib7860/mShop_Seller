
import '../../../model/add_to_cart_model/add_to_cart_count_model.dart';

abstract class AddToCartCountStates{

}

class AddToCartCountInitialState extends AddToCartCountStates{

}
class AddToCartCountLoadingState extends AddToCartCountStates{

}
class AddToCartCountLoadedState extends AddToCartCountStates{
  AddCartCountModel response;
  AddToCartCountLoadedState({required this.response});
}
class AddToCartCountErrorState extends AddToCartCountStates{
  String error;
  AddToCartCountErrorState({required this.error});
}