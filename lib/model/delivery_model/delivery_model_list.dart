class DeliveryBoyList {
  bool? result;
  int? status;
  List<Data>? data;

  DeliveryBoyList({this.result, this.status, this.data});

  DeliveryBoyList.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    status = json['status'];
    if (json.containsKey('data') && json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
  int? userId;
  String? nationality;
  String? emiratesIdNo;
  String? emiratesIdExpiry;
  String? emiratesId;
  String? visaNo;
  String? visaExpiry;
  String? visa;
  String? passportNo;
  String? passportExpiry;
  String? passport;
  String? licenseNo;
  String? licenseExpiry;
  String? license;
  String? addedBy;
  int? addedById;
  String? status;
  String? verified;
  String? name;
  String? email;
  String? phone;
  List<Warehouses>? warehouses;

  Data(
      {this.id,
      this.userId,
      this.nationality,
      this.emiratesIdNo,
      this.emiratesIdExpiry,
      this.emiratesId,
      this.visaNo,
      this.visaExpiry,
      this.visa,
      this.passportNo,
      this.passportExpiry,
      this.passport,
      this.licenseNo,
      this.licenseExpiry,
      this.license,
      this.addedBy,
      this.addedById,
      this.status,
      this.verified,
      this.name,
      this.email,
      this.phone,
      this.warehouses});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    nationality = json['nationality'];
    emiratesIdNo = json['emirates_id_no'];
    emiratesIdExpiry = json['emirates_id_expiry'];
    emiratesId = json['emirates_id'];
    visaNo = json['visa_no'];
    visaExpiry = json['visa_expiry'];
    visa = json['visa'];
    passportNo = json['passport_no'];
    passportExpiry = json['passport_expiry'];
    passport = json['passport'];
    licenseNo = json['license_no'];
    licenseExpiry = json['license_expiry'];
    license = json['license'];
    addedBy = json['added_by'];
    addedById = json['added_by_id'];
    status = json['status'];
    verified = json['verified'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    if (json['warehouses'] != null) {
      warehouses = <Warehouses>[];
      json['warehouses'].forEach((v) {
        warehouses!.add(new Warehouses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['nationality'] = this.nationality;
    data['emirates_id_no'] = this.emiratesIdNo;
    data['emirates_id_expiry'] = this.emiratesIdExpiry;
    data['emirates_id'] = this.emiratesId;
    data['visa_no'] = this.visaNo;
    data['visa_expiry'] = this.visaExpiry;
    data['visa'] = this.visa;
    data['passport_no'] = this.passportNo;
    data['passport_expiry'] = this.passportExpiry;
    data['passport'] = this.passport;
    data['license_no'] = this.licenseNo;
    data['license_expiry'] = this.licenseExpiry;
    data['license'] = this.license;
    data['added_by'] = this.addedBy;
    data['added_by_id'] = this.addedById;
    data['status'] = this.status;
    data['verified'] = this.verified;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    if (this.warehouses != null) {
      data['warehouses'] = this.warehouses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Warehouses {
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

  Warehouses(
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

  Warehouses.fromJson(Map<String, dynamic> json) {
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
