abstract class MyPaymentSendToAdminEvents{
  const MyPaymentSendToAdminEvents();

}
class MyPaymentSendToAdminEvent extends MyPaymentSendToAdminEvents {
int? count;
int? page;
  MyPaymentSendToAdminEvent({this.count,this.page});

}