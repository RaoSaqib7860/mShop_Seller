abstract class MyInvoiceEvents{
  const MyInvoiceEvents();

}
class MyInvoiceEvent extends MyInvoiceEvents {
int? count;
int? page;
  MyInvoiceEvent({this.page,this.count});

}