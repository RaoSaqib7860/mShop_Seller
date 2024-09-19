import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api_repo/api_utils.dart';
import '../../../model/add_to_cart_model/add_to_cart_count_model.dart';
import 'add_to_cart_count_events.dart';
import 'add_to_cart_count_state.dart';
class AddToCartCountBloc extends Bloc<AddToCartCountEvents, AddToCartCountStates> {
  DataProvider dataProvider =DataProvider();
  AddToCartCountBloc(super.initialState){
    on<AddToCartCountEvent>((event, emit) async{
      emit(AddToCartCountLoadingState());
      print('objectNot');
      AddCartCountModel response = await dataProvider.getCartCountingFunction();
      print('objectNot${response}');

      if(response != null){
        emit(AddToCartCountLoadedState(response: response));
      }else{
        emit(AddToCartCountErrorState(error: 'Invalid Data'));
      }
    });
  }

}