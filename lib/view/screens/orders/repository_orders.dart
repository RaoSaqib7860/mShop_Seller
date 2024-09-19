import 'package:mShop_Seller/model/delivery_model/delivery_model_list.dart'
    as model_warehouse;

import '../../../api_repo/api_utils.dart';
import '../../../model/order/company_type.dart';
import '../../../model/order/company_type.dart' as company_type;
import '../../../model/order/ware_house_model.dart' as wareHouse_model;
import '../../../model/order/ware_house_model.dart';

class orderDetailRepository {
  WareHouseModel? wareHouseModel;
  List<wareHouse_model.Data> list_wareHouse_model = [];
  String? slectedName;
  model_warehouse.Warehouses? selected_ware_house;
  CompanyTypeModel? company_type_model;
  company_type.Data? selected_company_type;
  Future get_wareHouse_list() async {
    wareHouseModel = await DataProvider.ware_house_api();
    company_type_model = await DataProvider.companyTypeModel();
  }
}
