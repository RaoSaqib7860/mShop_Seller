import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api_repo/api_utils.dart';
import 'add_cart_event.dart';
import 'add_cart_state.dart';
class AddToCartBloc extends Bloc<AddToCartEvents, AddToCartStates> {
  DataProvider dataProvider =DataProvider();
  AddToCartBloc(super.initialState){
    on<AddToCartEvent>((event, emit) async{
      emit(AddToCartLoadingState());
      bool response = await dataProvider.addToFunction(id: event.id,variant: event.variant,quantity: event.quantity,userId: event.userId);

      if(response == true){
        emit(AddToCartLoadedState());
      }else{
        emit(AddToCartErrorState(error: 'Invalid Data'));
      }
    });
  }

}