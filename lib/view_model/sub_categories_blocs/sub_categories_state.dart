


import '../../model/home_sub_category/get_all_product_categories_model.dart';
import '../../model/home_sub_category/sub_categories_model.dart';

abstract class SubCategoriesScreenState{

}

class SubCategoriesInitialState extends SubCategoriesScreenState{

}
class SubCategoriesLoadingState extends SubCategoriesScreenState{

}
class SubCategoriesLoadedState extends SubCategoriesScreenState{
  SubCategoriesModel response;
  GetAllProductOfCategories res;
  SubCategoriesLoadedState({required this.response, required this.res});
}
class SubCategoriesErrorState extends SubCategoriesScreenState{
  String error;
  SubCategoriesErrorState({required this.error});
}