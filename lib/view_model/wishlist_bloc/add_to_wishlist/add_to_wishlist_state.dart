


abstract class AddToWishlistStates{

}

class AddToWishlistInitialState extends AddToWishlistStates{

}
class AddToWishlistLoadingState extends AddToWishlistStates{

}
class AddToWishlistLoadedState extends AddToWishlistStates{

  AddToWishlistLoadedState();
}
class AddToWishlistErrorState extends AddToWishlistStates{
  String error;
  AddToWishlistErrorState({required this.error});
}