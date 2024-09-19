abstract class AddToCartEvents{
  const AddToCartEvents();

}
class AddToCartEvent extends AddToCartEvents{
  String? id;
  String? variant;
  String? userId;
  String? quantity;
  AddToCartEvent({this.id,this.variant,this.userId,this.quantity});

}