


import '../../model/home/home_screen_model.dart';
import '../../model/product/top_seller/top_seller_model.dart';

abstract class HomesState{

}

class HomesScreenInitialState extends HomesState{

}
class HomesScreenLoadingState extends HomesState{

}
class HomesScreenLoadedState extends HomesState{
  HomeScreenModel response;
  TopBestSellingProduct bestSellingProduct;
  HomesScreenLoadedState({required this.response,required this.bestSellingProduct});
}
class HomesScreenErrorState extends HomesState{
  String error;
  HomesScreenErrorState({required this.error});
}