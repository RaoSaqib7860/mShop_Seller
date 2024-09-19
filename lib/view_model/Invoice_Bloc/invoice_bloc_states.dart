import '../../../model/order/my_order_model.dart';
import '../../model/Invoice/invoice_model.dart';

abstract class MyInvoiceStates {}

class MyInvoiceInitialState extends MyInvoiceStates {}

class MyInvoiceLoadingState extends MyInvoiceStates {}

class MyInvoiceLoadedState extends MyInvoiceStates {
  invoiceModelView? response;
  MyInvoiceLoadedState(
      {required this.response,});
}

class MyInvoiceErrorState extends MyInvoiceStates {
  String error;
  MyInvoiceErrorState({required this.error});
}
