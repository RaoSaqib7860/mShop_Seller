import 'dart:convert';

CommissionModel commissionModelFromJson(String str) =>
    CommissionModel.fromJson(json.decode(str));

String commissionModelToJson(CommissionModel data) =>
    json.encode(data.toJson());

class CommissionModel {
  CommissionModel({
    this.result,
    this.status,
    this.data,
  });

  bool? result;
  int? status;
  Data? data;

  factory CommissionModel.fromJson(Map<String, dynamic> json) =>
      CommissionModel(
        result: json["result"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.currentPage,
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
    this.total,
  });

  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    this.id,
    this.orderId,
    this.orderDetailId,
    this.sellerId,
    this.adminCommission,
    this.sellerEarning,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
  });

  int? id;
  int? orderId;
  int? orderDetailId;
  int? sellerId;
  int? adminCommission;
  int? sellerEarning;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? orderNumber;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        orderId: json["order_id"],
        orderDetailId: json["order_detail_id"],
        sellerId: json["seller_id"],
        adminCommission: json["admin_commission"],
        sellerEarning: json["seller_earning"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        orderNumber: json["order_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "order_detail_id": orderDetailId,
        "seller_id": sellerId,
        "admin_commission": adminCommission,
        "seller_earning": sellerEarning,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "order_number": orderNumber,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}
