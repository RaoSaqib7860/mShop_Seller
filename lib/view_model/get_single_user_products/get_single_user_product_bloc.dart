import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_repo/api_utils.dart';
import '../../model/add_to_cart_model/add_to_cart_count_model.dart';
import '../../model/home_sub_category/get_product_single_user_model.dart';
import '../../model/wishlist_models/wishlist_count_model/wishlist_count.dart';
import 'get_single_user_product_event.dart';
import 'get_single_user_product_state.dart';

class GetSingleUserProductBloc
    extends Bloc<GetSingleUserProductEvents, GetSingleUserProductState> {
  DataProvider dataProvider = DataProvider();

  GetSingleUserProductBloc(GetSingleUserProductState initialState)
      : super(initialState) {
    on<SingleUserProductEvent>((event, emit) async {
      emit(GetSingleUserProductLoadingState());
      getProductSingleUserModel response =
          await dataProvider.getSingleUserProduct(Id: event.Id);
      AddCartCountModel res = await dataProvider.getCartCountingFunction();
      WishlistCountModel wishlistCount =
          await dataProvider.wishlistCountingFunction();
      if (response != null) {
        List<String>? selectedAllVariant = [];
        if (response.variants!.isNotEmpty) {
          response.choiceOptions!.map((e) {
            selectedAllVariant.add(e.options![0]);
          }).toList();
        }
        emit(GetSingleUserProductLoadedState(
            selectedAllVariant: selectedAllVariant,
            selectedColorsVariant:
                response.colors!.isEmpty ? '' : response.colors![0].name,
            response: response,
            count: response.minQty!));
      } else {
        emit(GetSingleUserProductErrorState(error: 'Something went Rong'));
      }
    });
  }
}
