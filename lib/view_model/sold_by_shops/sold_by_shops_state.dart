import '../../model/soled_by_shop/single_shop_model.dart';

abstract class ShopProductStates {}

class ShopProductInitialState extends ShopProductStates {}

class ShopProductLoadingState extends ShopProductStates {}

class ShopProductLoadedState extends ShopProductStates {
  GetAllProductsByShop response;

  ShopProductLoadedState({required this.response});
}

class ShopProductErrorState extends ShopProductStates {
  String error;

  ShopProductErrorState({required this.error});
}
