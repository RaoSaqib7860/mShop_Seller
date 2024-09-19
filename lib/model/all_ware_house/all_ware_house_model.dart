class allWareHouseModel {
  bool? result;
  int? status;
  Data? data;

  allWareHouseModel({this.result, this.status, this.data});

  allWareHouseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<DataView>? dataView;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  dynamic perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
        this.dataView,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      dataView = <DataView>[];
      json['data'].forEach((v) {
        dataView!.add(new DataView.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.dataView != null) {
      data['data'] = this.dataView!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class DataView {
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

  DataView(
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

  DataView.fromJson(Map<String, dynamic> json) {
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

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
