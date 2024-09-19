import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:mShop_Seller/api_repo/api_utils.dart';
import 'package:mShop_Seller/model/wearhouse/wearhouse_model.dart'
as wearhouse_model;
import '../../model/wearhouse/wearhouse_model.dart';

class DeliveryBoy {
  TextEditingController dateInput = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController eIdController = TextEditingController();
  TextEditingController visaNoController = TextEditingController();
  TextEditingController passportController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController visaExpiryDate = TextEditingController();
  TextEditingController passportExpiryDate = TextEditingController();
  TextEditingController licenceExpiryDate = TextEditingController();
  TextEditingController imageController = TextEditingController();
  String? countoryController;
  GetWearhouseList? wearHouseList;
  List<wearhouse_model.Data> list_of_selected_wearhouse=[];
  //String? name ;
  Future get_where_house_list() async {
    wearHouseList = await DataProvider().getWearHouseFunction();
  }
}
