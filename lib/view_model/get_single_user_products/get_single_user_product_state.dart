import '../../model/home_sub_category/get_product_single_user_model.dart';

abstract class GetSingleUserProductState {}

class GetSingleUserProductInitialState extends GetSingleUserProductState {}

class GetSingleUserProductLoadingState extends GetSingleUserProductState {}

class GetSingleUserProductLoadedState extends GetSingleUserProductState {
  getProductSingleUserModel? response;
  String? selectedColorsVariant = '';
  List<String>? selectedAllVariant = [];
  int? count;

  GetSingleUserProductLoadedState(
      {this.response,
      this.selectedAllVariant,
      this.selectedColorsVariant,
      this.count});
}

class GetSingleUserProductErrorState extends GetSingleUserProductState {
  String error;

  GetSingleUserProductErrorState({required this.error});
}
