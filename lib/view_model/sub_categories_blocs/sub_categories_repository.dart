import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mShop_Seller/view_model/sub_categories_blocs/sub_categories_bloc.dart';
import 'package:mShop_Seller/view_model/sub_categories_blocs/sub_categories_state.dart';

import '../../api_repo/api_utils.dart';
import '../../model/home_sub_category/get_all_product_categories_model.dart';

class SubCateGorybloc {
  SubCategoriesBloc subCategoriesBloc =
  SubCategoriesBloc(SubCategoriesInitialState());
  int page = 1;
  int count = 6;
  Future<GetAllProductOfCategories> getallProduct({String? cat_id}) async {
    page=page+1;
    GetAllProductOfCategories res = await DataProvider()
        .getAllProductCategories(Id: cat_id, page: page,count: count);
    return res;
  }
  int? cross_count = 2;
  String? style = 'grid';
  var refreshController = RefreshController(initialRefresh: false);
}