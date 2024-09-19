import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api_repo/api_utils.dart';
import '../../../model/delivery_model/delivery_model_list.dart';
import 'delivery_boy_events.dart';
import 'delivery_boy_state.dart';

class DeliveryBoyBloc
    extends Bloc<DeliveryBoyScreenEvents, DeliveryBoyListScreenState> {
  DataProvider dataProvider = DataProvider();

  DeliveryBoyBloc(super.initialState) {
    on<DeliveryBoyEvent>((event, emit) async {
      emit(DeliveryBoyListLoadingState());
      DeliveryBoyList? res = await dataProvider.getDeliveryBoyListFunction();
      if (res != null) {
        emit(DeliveryBoyListLoadedState(res: res));
      } else {
        emit(DeliveryBoyListErrorState(error: ''));
      }
    });
  }
}
