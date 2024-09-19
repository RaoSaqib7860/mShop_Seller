
import '../../../model/wishlist_models/add_wishlist_view_model/add_wishlist_view.dart';


abstract class WishlistViewStates{

}

class WishlistViewInitialState extends WishlistViewStates{

}
class WishlistViewLoadingState extends WishlistViewStates{

}
class WishlistViewLoadedState extends WishlistViewStates{
  AddWishlistViewModel response;

  WishlistViewLoadedState({required this.response, });
}
class WishlistViewErrorState extends WishlistViewStates{
  String error;
  WishlistViewErrorState({required this.error});
}