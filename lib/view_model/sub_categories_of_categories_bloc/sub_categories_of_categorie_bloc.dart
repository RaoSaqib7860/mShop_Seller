import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mShop_Seller/view_model/sub_categories_of_categories_bloc/sub_categories_of_categorie_events.dart';
import 'package:mShop_Seller/view_model/sub_categories_of_categories_bloc/sub_categories_of_categorie_state.dart';

import '../../api_repo/api_utils.dart';
import '../../model/home_sub_category/sub_categories_of_categories_model.dart';

class SubCategoriesOfCategoriesBloc extends Bloc<
    SubCategoriesOfCategoriesScreenEvents,
    SubCategoriesOfCategoriesScreenState> {
  DataProvider dataProvider = DataProvider();

  SubCategoriesOfCategoriesBloc(super.initialState) {
    on<SubCategoriesOfCategoriesEvent>((event, emit) async {
      emit(SubCategoriesOfCategoriesLoadingState());
      SubCategoriesOfCategoriesModel res =
          await dataProvider.getSubCategoriesOfCategoriesFunction(
              CategoryId: event.CategoryID, page: event.page);
      if (res != -1) {
        emit(SubCategoriesOfCategoriesLoadedState(res: res));
      } else {
        emit(SubCategoriesOfCategoriesErrorState(error: 'error msg'));
      }
    });
  }
}
