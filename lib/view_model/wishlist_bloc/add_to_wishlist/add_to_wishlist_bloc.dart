import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api_repo/api_utils.dart';
import 'add_to_wishlist_event.dart';
import 'add_to_wishlist_state.dart';

class AddToWishlistBloc extends Bloc<AddToWishlistEvents, AddToWishlistStates> {
  DataProvider dataProvider =DataProvider();
  AddToWishlistBloc(super.initialState){
    on<AddToWishlistEvent>((event, emit) async{
      emit(AddToWishlistLoadingState());
      bool response = await dataProvider.addToWishlistFunction(productId: event.productId);
      if(response == true ){
        emit(AddToWishlistLoadedState());
      }else{
        emit(AddToWishlistErrorState(error: 'Invalid Data'));
      }
    });
  }

}