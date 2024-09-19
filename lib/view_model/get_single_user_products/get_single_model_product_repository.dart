import 'dart:async';

import '../../api_repo/api_utils.dart';
import '../../model/add_to_cart_model/add_to_cart_count_model.dart';
import '../../model/home_sub_category/get_product_single_user_model.dart';
import '../../model/wishlist_models/wishlist_count_model/wishlist_count.dart';
import '../../utils_services/storage_util.dart';
import '../add_to_cart/add_cart/add_cart_bloc.dart';
import '../add_to_cart/add_cart/add_cart_state.dart';
import '../add_to_cart/add_to_cart_count/add_to_cart_count_bloc.dart';
import '../add_to_cart/add_to_cart_count/add_to_cart_count_state.dart';
import '../wishlist_bloc/add_to_wishlist/add_to_wishlist_bloc.dart';
import '../wishlist_bloc/add_to_wishlist/add_to_wishlist_state.dart';
import 'get_single_user_product_bloc.dart';
import 'get_single_user_product_state.dart';

class GetSingleUserProductRepository {
  GetSingleUserProductBloc getSingleUserProductBloc =
      GetSingleUserProductBloc(GetSingleUserProductInitialState());
  String Selected = '';
  AddToCartBloc addToCartBloc = AddToCartBloc(AddToCartInitialState());
  AddToCartCountBloc counterBloc =
      AddToCartCountBloc(AddToCartCountInitialState());
  AddToWishlistBloc addToWishlistBloc =
      AddToWishlistBloc(AddToWishlistInitialState());
  StreamSubscription? subscription;
  ADDToCartObject addToCardData = ADDToCartObject(data: []);
  AddCartCountModel? res;
  WishlistCountModel? wishlistCount;
  bool load_data = false;
  Future get_count_and_wishList() async {
    res = await DataProvider().getCartCountingFunction();
    if (storage.hasData('userData')) {
      wishlistCount = await DataProvider().wishlistCountingFunction();
    }
  }

  Future addtoWishList({String? id}) async {
    await DataProvider().addToWishlistFunction(productId: id);
    await get_count_and_wishList();
  }
}
