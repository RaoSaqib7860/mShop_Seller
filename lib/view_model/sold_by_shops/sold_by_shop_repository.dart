import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mShop_Seller/view_model/sold_by_shops/sold_by_shops_bloc.dart';
import 'package:mShop_Seller/view_model/sold_by_shops/sold_by_shops_state.dart';

import '../../api_repo/api_utils.dart';
import '../../model/soled_by_shop/single_shop_model.dart';

class SoldByShopRepository {
  ShopProductBloc shopProductBloc = ShopProductBloc(ShopProductInitialState());
  String? count = '2';
  String? style = 'grid';
  int page = 1;
  var refreshController = RefreshController(initialRefresh: false);
  Future<GetAllProductsByShop> getLoadMoreData(String? id) async {
    page = page + 1;
    GetAllProductsByShop response = await DataProvider()
        .allProductsByShopFunction(Id: id, page: '${page}', count: '12');
    print('${page}');
    return response;
  }
}
