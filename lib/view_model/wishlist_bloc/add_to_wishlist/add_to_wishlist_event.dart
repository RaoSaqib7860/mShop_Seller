abstract class AddToWishlistEvents{
  const AddToWishlistEvents();

}
class AddToWishlistEvent extends AddToWishlistEvents{
  String? productId;


  AddToWishlistEvent({this.productId,});

}