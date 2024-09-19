import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api_repo/api_utils.dart';
import '../../../model/add_to_cart_model/add_to_cart_list.dart';
import '../../../model/add_to_cart_model/add_to_cart_summary_model.dart';
import 'add_to_cart_lists_events.dart';
import 'add_to_cart_lists_states.dart';




class AddToCartListBloc extends Bloc<AddToCartListEvents, AddToCartListStates> {
  DataProvider dataProvider = DataProvider();

  AddToCartListBloc(super.initialState) {
  on<AddToCartListEvent>((event, emit) async{
    emit(AddToCartListLoadingState());
    AddToCartList response = await dataProvider.addToCartListFunction();
    AddToCartSummaryModel res = await dataProvider.addToCartSummaryFunction();
    if(response != -1 || res != -1){
      emit(AddToCartListLoadedState(response: response,res: res));
    }else{
      emit(AddToCartListErrorState(error: 'Invalid Data'));
    }
  });}
}
