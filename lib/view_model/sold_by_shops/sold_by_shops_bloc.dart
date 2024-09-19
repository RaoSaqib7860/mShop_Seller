import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mShop_Seller/view_model/sold_by_shops/sold_by_shops_events.dart';
import 'package:mShop_Seller/view_model/sold_by_shops/sold_by_shops_state.dart';

import '../../../api_repo/api_utils.dart';
import '../../model/soled_by_shop/single_shop_model.dart';

class ShopProductBloc extends Bloc<ShopProductEvents, ShopProductStates> {
  ShopProductBloc(super.initialState) {
    on<ShopProductEvent>((event, emit) async {
      print('ShopProductBloc = ${event.Id}');
      emit(ShopProductLoadingState());
      GetAllProductsByShop response;
      if (event.is_brand!) {
        response = await DataProvider()
            .allProductsByBrandFunction(Id: event.Id, page: '1', count: '12');
      } else if (event.is_stages!) {
        response = await DataProvider()
            .allProductsByStagesFunction(Id: event.Id, page: '1', count: '12');
      } else {
        response = await DataProvider()
            .allProductsByShopFunction(Id: event.Id, page: '1', count: '12');
      }
      if (response != -1) {
        emit(ShopProductLoadedState(response: response));
      } else {
        emit(ShopProductErrorState(error: 'Invalid Data'));
      }
    });
  }
}
