import 'package:flutter/material.dart';

import '../../../../api_repo/api_utils.dart';

import '../../../../model/verification_page/city.dart';
import '../../../../model/verification_page/states.dart' as state_model_is;
import '../../../../model/verification_page/states.dart';
import 'package:mShop_Seller/model/verification_page/city.dart' as city_model_is;
class addWarehouseRepository {

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String store_google_location_address = '';
  double store_location_lat = 0.0;
  double store_location_lng = 0.0;
  double store_pickup_location_lat = 0.0;
  double store_pickup_location_lng = 0.0;

  City? owner_allCites;
  States? statesModelClass;
  String? val;
  String owner_selected_state = '';
  String owner_selected_city = '';
  List<state_model_is.Data> list_state_model=[];
  List<city_model_is.Data> list_city_model=[];
  Future get_states_list() async {
    statesModelClass = await DataProvider().get_all_states();
  }

  Future get_city_by_cites(String? id) async {
    owner_allCites = await DataProvider.get_cites_by_state(id: id);
  }
}