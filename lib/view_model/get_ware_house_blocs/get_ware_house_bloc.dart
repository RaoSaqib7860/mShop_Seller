import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api_repo/api_utils.dart';
import '../../model/all_ware_house/all_ware_house_model.dart';
import '../../model/order/ware_house_model.dart';
import 'get_ware_house_events.dart';
import 'get_ware_house_state.dart';



class MyWareHouseListBloc extends Bloc<MyWareHouseListEvents, MyWareHouseListStates> {
  DataProvider dataProvider = DataProvider();

  MyWareHouseListBloc(super.initialState) {
    on<MyWareHouseListEvent>((event, emit) async {
      emit(MyWareHouseListLoadingState());
      allWareHouseModel? response = await dataProvider.ware_house_all_api(page: event.page,count: event.count);
      if (response != null) {
        emit(MyWareHouseListLoadedState(response: response));
      } else {
        emit(MyWareHouseListErrorState(error: 'Invalid Data'));
      }
    });
  }
}
