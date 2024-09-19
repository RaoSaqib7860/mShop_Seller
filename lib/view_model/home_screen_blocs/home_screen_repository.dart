import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';

import '../../model/home_sub_category/ProductSearchModel.dart';

class HomeScreenRepository {
  var searchText = ''.obs;
  ProductSearchModel? search_result;
  Future get_search_data(String? value) async {
    ProductSearchModel? result = await DataProvider.get_search_product(value: value);
    print('${result!.status}');
    search_result=result;
  }
  TextEditingController search_controller=TextEditingController();
}
