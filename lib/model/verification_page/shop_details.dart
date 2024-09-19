class ShopDetails {
  bool? result;
  Shop? shop;
  List<Warehouses>? warehouses;

  ShopDetails({this.result, this.shop, this.warehouses});

  ShopDetails.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    if (json['warehouses'] != null) {
      warehouses = <Warehouses>[];
      json['warehouses'].forEach((v) {
        warehouses!.add(new Warehouses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    if (this.warehouses != null) {
      data['warehouses'] = this.warehouses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shop {
  int? id;
  int? sellerId;
  int? shopId;
  String? shopName;
  String? shopPhone;
  String? shopAddress;
  String? shopCountry;
  String? shopState;
  String? shopCity;
  String? shopGoogleLocation;
  String? ownerName;
  String? ownerAddress;
  String? ownerCountry;
  String? ownerState;
  String? ownerCity;
  dynamic ownerZip;
  String? ownerMobile;
  String? ownerEmail;
  String? ownerType;
  String? ownerIdType;
  String? ownerIdProof;
  String? idIssueDate;
  String? idExpiryDate;
  String? warehouseName;
  String? warehouseAddress;
  String? warehouseCountry;
  String? warehouseState;
  String? warehouseCity;
  String? warehouseZip;
  String? warehouseGoogleLocation;
  String? warehousePickupAddress;
  String? warehousePickupState;
  String? warehousePickupCity;
  String? warehousePickupMap;
  String? warehouseContact;
  dynamic warehouseEmail;
  String? licenseNo;
  String? issueDate;
  String? expiryDate;
  String? issueAuthority;
  String? licenseActivity;
  String? vatRegistered;
  String? vatNo;
  String? imgLicense;
  String? imgVat;
  String? beneficiaryName;
  String? bankName;
  String? branchCity;
  String? iBAN;
  String? accountNo;
  String? swiftCode;
  String? currency;
  String? paymentMode;
  String? isVerified;

  Shop(
      {this.id,
        this.sellerId,
        this.shopId,
        this.shopName,
        this.shopPhone,
        this.shopAddress,
        this.shopCountry,
        this.shopState,
        this.shopCity,
        this.shopGoogleLocation,
        this.ownerName,
        this.ownerAddress,
        this.ownerCountry,
        this.ownerState,
        this.ownerCity,
        this.ownerZip,
        this.ownerMobile,
        this.ownerEmail,
        this.ownerType,
        this.ownerIdType,
        this.ownerIdProof,
        this.idIssueDate,
        this.idExpiryDate,
        this.warehouseName,
        this.warehouseAddress,
        this.warehouseCountry,
        this.warehouseState,
        this.warehouseCity,
        this.warehouseZip,
        this.warehouseGoogleLocation,
        this.warehousePickupAddress,
        this.warehousePickupState,
        this.warehousePickupCity,
        this.warehousePickupMap,
        this.warehouseContact,
        this.warehouseEmail,
        this.licenseNo,
        this.issueDate,
        this.expiryDate,
        this.issueAuthority,
        this.licenseActivity,
        this.vatRegistered,
        this.vatNo,
        this.imgLicense,
        this.imgVat,
        this.beneficiaryName,
        this.bankName,
        this.branchCity,
        this.iBAN,
        this.accountNo,
        this.swiftCode,
        this.currency,
        this.paymentMode,
        this.isVerified});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    shopPhone = json['shop_phone'];
    shopAddress = json['shop_address'];
    shopCountry = json['shop_country'];
    shopState = json['shop_state'];
    shopCity = json['shop_city'];
    shopGoogleLocation = json['shop_google_location'];
    ownerName = json['owner_name'];
    ownerAddress = json['owner_address'];
    ownerCountry = json['owner_country'];
    ownerState = json['owner_state'];
    ownerCity = json['owner_city'];
    ownerZip = json['owner_zip'];
    ownerMobile = json['owner_mobile'];
    ownerEmail = json['owner_email'];
    ownerType = json['owner_type'];
    ownerIdType = json['owner_id_type'];
    ownerIdProof = json['owner_id_proof'];
    idIssueDate = json['id_issue_date'];
    idExpiryDate = json['id_expiry_date'];
    warehouseName = json['warehouse_name'];
    warehouseAddress = json['warehouse_address'];
    warehouseCountry = json['warehouse_country'];
    warehouseState = json['warehouse_state'];
    warehouseCity = json['warehouse_city'];
    warehouseZip = json['warehouse_zip'];
    warehouseGoogleLocation = json['warehouse_google_Location'];
    warehousePickupAddress = json['warehouse_pickup_address'];
    warehousePickupState = json['warehouse_pickup_state'];
    warehousePickupCity = json['warehouse_pickup_city'];
    warehousePickupMap = json['warehouse_pickup_map'];
    warehouseContact = json['warehouse_contact'];
    warehouseEmail = json['warehouse_email']??[];
    licenseNo = json['license_no'];
    issueDate = json['issue_date'];
    expiryDate = json['expiry_date'];
    issueAuthority = json['issue_authority'];
    licenseActivity = json['license_activity'];
    vatRegistered = json['vat_registered'];
    vatNo = json['vat_no'];
    imgLicense = json['img_license'];
    imgVat = json['img_vat'];
    beneficiaryName = json['beneficiary_name'];
    bankName = json['bank_name'];
    branchCity = json['branch_city'];
    iBAN = json['IBAN'];
    accountNo = json['account_no'];
    swiftCode = json['swift_code'];
    currency = json['currency'];
    paymentMode = json['payment_mode'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
    data['shop_id'] = this.shopId;
    data['shop_name'] = this.shopName;
    data['shop_phone'] = this.shopPhone;
    data['shop_address'] = this.shopAddress;
    data['shop_country'] = this.shopCountry;
    data['shop_state'] = this.shopState;
    data['shop_city'] = this.shopCity;
    data['shop_google_location'] = this.shopGoogleLocation;
    data['owner_name'] = this.ownerName;
    data['owner_address'] = this.ownerAddress;
    data['owner_country'] = this.ownerCountry;
    data['owner_state'] = this.ownerState;
    data['owner_city'] = this.ownerCity;
    data['owner_zip'] = this.ownerZip;
    data['owner_mobile'] = this.ownerMobile;
    data['owner_email'] = this.ownerEmail;
    data['owner_type'] = this.ownerType;
    data['owner_id_type'] = this.ownerIdType;
    data['owner_id_proof'] = this.ownerIdProof;
    data['id_issue_date'] = this.idIssueDate;
    data['id_expiry_date'] = this.idExpiryDate;
    data['warehouse_name'] = this.warehouseName;
    data['warehouse_address'] = this.warehouseAddress;
    data['warehouse_country'] = this.warehouseCountry;
    data['warehouse_state'] = this.warehouseState;
    data['warehouse_city'] = this.warehouseCity;
    data['warehouse_zip'] = this.warehouseZip;
    data['warehouse_google_Location'] = this.warehouseGoogleLocation;
    data['warehouse_pickup_address'] = this.warehousePickupAddress;
    data['warehouse_pickup_state'] = this.warehousePickupState;
    data['warehouse_pickup_city'] = this.warehousePickupCity;
    data['warehouse_pickup_map'] = this.warehousePickupMap;
    data['warehouse_contact'] = this.warehouseContact;
    data['warehouse_email'] = this.warehouseEmail;
    data['license_no'] = this.licenseNo;
    data['issue_date'] = this.issueDate;
    data['expiry_date'] = this.expiryDate;
    data['issue_authority'] = this.issueAuthority;
    data['license_activity'] = this.licenseActivity;
    data['vat_registered'] = this.vatRegistered;
    data['vat_no'] = this.vatNo;
    data['img_license'] = this.imgLicense;
    data['img_vat'] = this.imgVat;
    data['beneficiary_name'] = this.beneficiaryName;
    data['bank_name'] = this.bankName;
    data['branch_city'] = this.branchCity;
    data['IBAN'] = this.iBAN;
    data['account_no'] = this.accountNo;
    data['swift_code'] = this.swiftCode;
    data['currency'] = this.currency;
    data['payment_mode'] = this.paymentMode;
    data['is_verified'] = this.isVerified;
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
        this.status});

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
    return data;
  }
}
