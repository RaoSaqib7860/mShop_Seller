import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api_repo/api_utils.dart';
import '../../model/commission_history/commission_history_model.dart';
import 'commission_history_events.dart';
import 'commission_history_state.dart';


class MyCommissionHistoryBloc extends Bloc<MyCommissionHistoryEvents, MyCommissionHistoryStates> {
  DataProvider dataProvider = DataProvider();

  MyCommissionHistoryBloc(super.initialState) {
    on<MyCommissionHistoryEvent>((event, emit) async {
      emit(MyCommissionHistoryLoadingState());
      CommissionHistory response = await dataProvider.getCommissionHistoryFunction();
      if (response != -1) {
        emit(MyCommissionHistoryLoadedState(response: response));
      } else {
        emit(MyCommissionHistoryErrorState(error: 'Invalid Data'));
      }
    });
  }
}
