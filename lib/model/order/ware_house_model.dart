import 'package:mShop_Seller/model/delivery_model/delivery_model_list.dart';

class WareHouseModel {
  bool? result;
  int? status;
  List<Warehouses>? data;

  WareHouseModel({this.result, this.status, this.data});

  WareHouseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Warehouses>[];
      json['data']['data'].forEach((v) {
        data!.add(new Warehouses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? shopVerificationId;
  int? shopId;
  String? warehouseName;
  String? warehouseAddress;
  String? warehouseCountry;
  String? warehouseCity;
  String? warehouseContact;
  String? warehouseState;
  String? warehouseGoogleLocation;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Data(
      {this.id,
        this.shopVerificationId,
        this.shopId,
        this.warehouseName,
        this.warehouseAddress,
        this.warehouseCountry,
        this.warehouseCity,
        this.warehouseContact,
        this.warehouseState,
        this.warehouseGoogleLocation,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopVerificationId = json['shop_verification_id'];
    shopId = json['shop_id'];
    warehouseName = json['warehouse_name'];
    warehouseAddress = json['warehouse_address'];
    warehouseCountry = json['warehouse_country'];
    warehouseCity = json['warehouse_city'];
    warehouseContact = json['warehouse_contact'];
    warehouseState = json['warehouse_state'];
    warehouseGoogleLocation = json['warehouse_google_Location'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_verification_id'] = this.shopVerificationId;
    data['shop_id'] = this.shopId;
    data['warehouse_name'] = this.warehouseName;
    data['warehouse_address'] = this.warehouseAddress;
    data['warehouse_country'] = this.warehouseCountry;
    data['warehouse_city'] = this.warehouseCity;
    data['warehouse_contact'] = this.warehouseContact;
    data['warehouse_state'] = this.warehouseState;
    data['warehouse_google_Location'] = this.warehouseGoogleLocation;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
