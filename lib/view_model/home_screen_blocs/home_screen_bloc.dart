import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/home/home_screen_model.dart' as home_model;
import '../../api_repo/api_utils.dart';
import '../../model/home/home_screen_model.dart';
import '../../model/product/top_seller/top_seller_model.dart';
import 'home_screen_event.dart';
import 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomesScreenEvents, HomesState> {
  DataProvider dataProvider = DataProvider();
  HomeScreenBloc(HomesState initialState) : super(initialState) {
    on<HomeModelsHome>((event, emit) async {
      emit(HomesScreenLoadingState());
      HomeScreenModel response = await dataProvider.getHome();
      response.data!.insert(
          0,
          home_model.Data(
              id: -1, icon: 'assets/image/all_product.png', name: 'All'));
      TopBestSellingProduct bestSellingProduct =
          await dataProvider.topBestSeller();
      if (response != null) {
        emit(HomesScreenLoadedState(
            response: response, bestSellingProduct: bestSellingProduct));
      } else {
        emit(HomesScreenErrorState(error: 'error'));
      }
    });
  }
}
