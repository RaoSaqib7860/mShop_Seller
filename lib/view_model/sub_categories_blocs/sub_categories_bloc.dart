import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mShop_Seller/view_model/sub_categories_blocs/sub_categories_event.dart';
import 'package:mShop_Seller/view_model/sub_categories_blocs/sub_categories_state.dart';

import '../../api_repo/api_utils.dart';
import '../../model/home_sub_category/get_all_product_categories_model.dart';
import '../../model/home_sub_category/sub_categories_model.dart';

class SubCategoriesBloc
    extends Bloc<SubCategoriesScreenEvents, SubCategoriesScreenState> {
  DataProvider dataProvider = DataProvider();

  SubCategoriesBloc(SubCategoriesScreenState initialState)
      : super(initialState) {
    on<SubCategoriesEvent>((event, emit) async {
      emit(SubCategoriesLoadingState());
      SubCategoriesModel response =
          await dataProvider.getSubCategories(event.ID);
      print('${event.catId} and ${event.page}');
      if (event.catId != '-1') {
        GetAllProductOfCategories res;
        if (event.has_sub_cat!) {
          res = await dataProvider.getSubCategoriesOfCategoriesFunction(
              CategoryId: event.catId, page: event.page);
        }else{
          res = await dataProvider.getAllProductCategories(
              Id: event.catId, page: event.page);
        }
        if (response != null || res != null) {
          emit(SubCategoriesLoadedState(response: response, res: res));
        } else {
          emit(SubCategoriesErrorState(error: 'error msg'));
        }
      } else {
        GetAllProductOfCategories res = await dataProvider.getAllProduct();
        if (response != null || res != null) {
          emit(SubCategoriesLoadedState(response: response, res: res));
        } else {
          emit(SubCategoriesErrorState(error: 'error msg'));
        }
      }
    });
  }
}
