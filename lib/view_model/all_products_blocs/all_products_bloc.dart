import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api_repo/api_utils.dart';
import '../../model/All Products/all_products_model.dart';
import 'all_product_event.dart';
import 'all_product_state.dart';

class allProductBloc extends Bloc<AllProductScreenEvent, AllProductState> {
  DataProvider dataProvider = DataProvider();

  allProductBloc(super.initialState) {
    on<AllProductEvent>((event, emit) async {
      emit(AllProductLoadingState());
      GetAllProductModels? response =
          await dataProvider.get_all_product_Functions();
      if (response != null) {
        emit(AllProductLoadedState(response: response));
      } else {
        emit(AllProductErrorState(error: 'Invalid Data'));
      }
    });
  }
}
