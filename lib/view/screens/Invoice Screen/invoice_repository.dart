import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../api_repo/api_utils.dart';
import '../../../model/Invoice/invoice_model.dart';
import '../../../view_model/Invoice_Bloc/invoice_bloc_states.dart';
import '../../../view_model/Invoice_Bloc/invoice_bloc_view.dart';

class invoiceRepo{
  var refreshController = RefreshController(initialRefresh: false);
  int? count = 20;
  int page = 1;
  MyInvoiceBloc myInvoiceBloc = MyInvoiceBloc(MyInvoiceInitialState());
  Future<invoiceModelView> getInvoiceProduct() async {
    page = page + 1;
    invoiceModelView res = await DataProvider()
        .viewInvoiceFunction( page: page,count: count);
    return res;
  }
}