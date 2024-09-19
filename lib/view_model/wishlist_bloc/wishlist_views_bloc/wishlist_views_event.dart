abstract class WishlistViewEvents{
  const WishlistViewEvents();

}
class WishlistViewEvent extends WishlistViewEvents{
  String? productIdRemove;
  WishlistViewEvent({this.productIdRemove});

}