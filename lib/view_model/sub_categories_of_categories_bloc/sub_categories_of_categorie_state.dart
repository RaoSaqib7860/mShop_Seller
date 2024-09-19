
import '../../model/home_sub_category/sub_categories_of_categories_model.dart';

abstract class SubCategoriesOfCategoriesScreenState{

}

class SubCategoriesOfCategoriesInitialState extends SubCategoriesOfCategoriesScreenState{

}
class SubCategoriesOfCategoriesLoadingState extends SubCategoriesOfCategoriesScreenState{

}
class SubCategoriesOfCategoriesLoadedState extends SubCategoriesOfCategoriesScreenState{

  SubCategoriesOfCategoriesModel res;
  SubCategoriesOfCategoriesLoadedState({ required this.res});
}
class SubCategoriesOfCategoriesErrorState extends SubCategoriesOfCategoriesScreenState{
  String error;
  SubCategoriesOfCategoriesErrorState({required this.error});
}