import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../api_repo/api_utils.dart';
import '../../../model/all_ware_house/all_ware_house_model.dart';
import '../../../view_model/get_ware_house_blocs/get_ware_house_bloc.dart';
import '../../../view_model/get_ware_house_blocs/get_ware_house_state.dart';

class getWarehousePagination {
  MyWareHouseListBloc wareHouseListBloc =
      MyWareHouseListBloc(MyWareHouseListInitialState());

  var refreshController = RefreshController(initialRefresh: false);
  int? page = 1;
  int? count = 10;
  Future<allWareHouseModel> getwarehouse() async {
    page = page! + 1;
    allWareHouseModel res =
        await DataProvider().ware_house_all_api(page: page, count: count);

    return res;
  }
}
