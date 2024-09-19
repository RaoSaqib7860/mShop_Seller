import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mShop_Seller/model/order/my_order_model.dart';
import '../../../api_repo/api_utils.dart';
import '../../model/Compaigns/compaign_model.dart';
import 'campaigns_events.dart';
import 'campaigns_states.dart';


class MyCompaignsBloc extends Bloc<MyCompaignsEvents, MyCompaignsStates> {
  DataProvider dataProvider = DataProvider();

  MyCompaignsBloc(super.initialState) {
    on<MyCompaignsEvent>((event, emit) async {
      emit(MyCompaignsLoadingState());
      CompaignModel response = await dataProvider.get_compaign_function(count: event.count,page: event.page);
      if (response != -1) {
        emit(MyCompaignsLoadedState(response: response));
      } else {
        emit(MyCompaignsErrorState(error: 'Invalid Data'));
      }
    });
  }
}
