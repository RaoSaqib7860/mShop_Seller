abstract class OrdersDetailEvents{
  const OrdersDetailEvents();

}
class OrdersDetailEvent extends OrdersDetailEvents {
  String? Id;
  OrdersDetailEvent({this.Id});

}