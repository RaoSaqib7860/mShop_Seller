import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../api_repo/api_utils.dart';
import '../../../model/payment_sent_to_admin/payment_sent_to_admin_model.dart';
import '../../../view_model/payment_sent_blocs/payment_send_to_admin_bloc.dart';
import '../../../view_model/payment_sent_blocs/payment_send_to_admin_state.dart';


class getPaymentPagination{
  var refreshController = RefreshController(initialRefresh: false);
  MyPaymentSendToAdminBloc myPaymentSendToAdminBloc =
  MyPaymentSendToAdminBloc(MyPaymentSendToAdminInitialState());
  int? page = 1 ;
  int? count = 6  ;
  Future<PaymentSentModel> getPayment() async {
    page= page! + 1;
    PaymentSentModel? res = await DataProvider()
        .paymentToAdminFunction(page: page,count: count);

    return res!;
  }
}