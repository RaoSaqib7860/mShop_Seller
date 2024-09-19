import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../api_repo/api_utils.dart';
import '../../../model/Compaigns/campaing_search_model.dart';
import '../../../view_model/all_products_blocs/all_product_state.dart';
import '../../../view_model/all_products_blocs/all_products_bloc.dart';

class CampaignSearchRepository{
  List selected_ids = [];
  List deSelected_ids = [];
  TextEditingController searchController = TextEditingController();
  String dropdownvalue = 'flat'.tr;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  DataProvider dataProvider = DataProvider();

  // List of items in our dropdown menu
  var items = [
    'flat'.tr,
    'percent'.tr,
  ];
  bool checkBoxValue = false;
  allProductBloc myAllProductBloc = allProductBloc(AllProductInitialState());

  CampaignSearchModel? campaignSearchModel;
  String? searchText ='';
  Future get_search_campaign({String? value}) async {
    campaignSearchModel = await DataProvider().get_search_product_campaign(text: value);

  }

}