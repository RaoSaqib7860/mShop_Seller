import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mShop_Seller/view_model/sub_categories_of_categories_bloc/sub_categories_of_categorie_bloc.dart';
import 'package:mShop_Seller/view_model/sub_categories_of_categories_bloc/sub_categories_of_categorie_state.dart';

import '../../api_repo/api_utils.dart';
import '../../model/home_sub_category/sub_categories_of_categories_model.dart';

class categoriesOfSubCategories{
  SubCategoriesOfCategoriesBloc categoriesOfCategoriesBloc =
  SubCategoriesOfCategoriesBloc(SubCategoriesOfCategoriesInitialState());

  var refreshController = RefreshController(initialRefresh: false);
  int page =1 ;
  Future<SubCategoriesOfCategoriesModel> getCategoriesProduct({String? cat_id}) async {

    SubCategoriesOfCategoriesModel res = await DataProvider()
        .getSubCategoriesOfCategoriesFunction(page: page, CategoryId: cat_id,);
    page=page +1;
    return res;
  }
}