import '../../model/All Products/all_products_model.dart';

abstract class AllProductState {}

class AllProductInitialState extends AllProductState {}

class AllProductLoadingState extends AllProductState {}

class AllProductLoadedState extends AllProductState {
  GetAllProductModels? response;
  AllProductLoadedState({this.response});
}

class AllProductErrorState extends AllProductState {
  String? error;
  AllProductErrorState({this.error});
}
