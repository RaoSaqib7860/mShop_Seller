class CommissionHistory {
  bool? result;
  int? status;
  Data? data;

  CommissionHistory({this.result, this.status, this.data});

  CommissionHistory.fromJson(Map<String, dynamic> json) {
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
  List<DataList>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.data,
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
      data = <DataList>[];
      json['data'].forEach((v) {
        data!.add(new DataList.fromJson(v));
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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

class DataList {
  int? id;
  int? orderId;
  int? orderDetailId;
  int? sellerId;
  dynamic adminCommission;
  dynamic sellerEarning;
  int? deliveryCompanyCharges;
  String? createdAt;
  String? updatedAt;
  String? orderNumber;
  String? paymentVerified;
  String? service_fee;
  String? paymentMethod;
  bool? paymentTransfer;
  String? paymentReceipt;
  dynamic payToAdmin;
  int? delivered_by_housy;
  int? delivered_by_seller;

  DataList(
      {this.id,
      this.orderId,
      this.orderDetailId,
      this.sellerId,
      this.adminCommission,
      this.sellerEarning,
      this.deliveryCompanyCharges,
      this.createdAt,
      this.updatedAt,
      this.orderNumber,
      this.paymentVerified,
      this.paymentMethod,
      this.paymentTransfer,
        this.service_fee,
      this.paymentReceipt,
      this.payToAdmin,
      this.delivered_by_housy,
      this.delivered_by_seller});

  DataList.fromJson(Map<String, dynamic> json) {
    delivered_by_housy = json['delivered_by_housy'];
    delivered_by_seller = json['delivered_by_seller'];
    id = json['id'];
    service_fee=json['service_fee'].toString();
    orderId = json['order_id'];
    orderDetailId = json['order_detail_id'];
    sellerId = json['seller_id'];
    adminCommission = json['admin_commission'];
    sellerEarning = json['seller_earning'];
    deliveryCompanyCharges = json['delivery_company_charges'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderNumber = json['order_number'];
    paymentVerified = json['payment_verified'];
    paymentMethod = json['payment_method'];
    paymentTransfer = json['Payment_Transfer'];
    paymentReceipt = json['Payment_Receipt'];
    payToAdmin = json['pay_to_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['order_detail_id'] = this.orderDetailId;
    data['seller_id'] = this.sellerId;
    data['admin_commission'] = this.adminCommission;
    data['seller_earning'] = this.sellerEarning;
    data['delivery_company_charges'] = this.deliveryCompanyCharges;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_number'] = this.orderNumber;
    data['payment_verified'] = this.paymentVerified;
    data['payment_method'] = this.paymentMethod;
    data['Payment_Transfer'] = this.paymentTransfer;
    data['Payment_Receipt'] = this.paymentReceipt;
    data['pay_to_admin'] = this.payToAdmin;
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
