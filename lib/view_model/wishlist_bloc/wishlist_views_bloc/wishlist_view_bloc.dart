import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mShop_Seller/view_model/wishlist_bloc/wishlist_views_bloc/wishlist_views_event.dart';
import 'package:mShop_Seller/view_model/wishlist_bloc/wishlist_views_bloc/wishlist_views_state.dart';
import '../../../api_repo/api_utils.dart';
import '../../../model/wishlist_models/add_wishlist_view_model/add_wishlist_view.dart';





class WishlistViewBloc extends Bloc<WishlistViewEvents, WishlistViewStates> {
  DataProvider dataProvider = DataProvider();

  WishlistViewBloc(super.initialState) {
    on<WishlistViewEvent>((event, emit) async{
      emit(WishlistViewLoadingState());
      AddWishlistViewModel response = await dataProvider.wishlistViewFunction();
      bool res = await dataProvider.removeToWishlistFunction(productIdRemove: event.productIdRemove);
      if(response != -1 ){
        emit(WishlistViewLoadedState(response: response,));
      }else{
        emit(WishlistViewErrorState(error: 'Invalid Data'));
      }
    });}
}
