// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  bool results;
  int count;
  Data data;

  NotificationModel({
    required this.results,
    required this.count,
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        results: json["results"],
        count: json["count"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "results": results,
        "count": count,
        "data": data.toJson(),
      };
}

class Data {
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  String perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"] ?? 0,
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] ?? 0,
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int id;
  App app;
  String notificationId;
  String notificationHeading;
  String notificationContent;
  String? userExternalIds;
  int orderId;
  Action? action;
  int visited;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.app,
    required this.notificationId,
    required this.notificationHeading,
    required this.notificationContent,
    required this.userExternalIds,
    required this.orderId,
    required this.action,
    required this.visited,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        app: appValues.map[json["app"]]!,
        notificationId: json["notification_id"],
        notificationHeading: json["notification_heading"] ?? '',
        notificationContent: json["notification_content"],
        userExternalIds: json["user_external_ids"],
        orderId: json["order_id"],
        action: actionValues.map[json["action"]],
        visited: json["visited"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "app": appValues.reverse[app],
        "notification_id": notificationId,
        "notification_heading":
            notificationHeadingValues.reverse[notificationHeading],
        "notification_content": notificationContent,
        "user_external_ids": userExternalIdsValues.reverse[userExternalIds],
        "order_id": orderId,
        "hash_code": hashCode,
        "action": actionValues.reverse[action],
        "visited": visited,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum Action { ORDER_DETAIL, EMPTY }

final actionValues =
    EnumValues({"": Action.EMPTY, "order_detail": Action.ORDER_DETAIL});

enum App { STAGING_SELLER }

final appValues = EnumValues({"staging-seller": App.STAGING_SELLER});

enum NotificationHeading {
  ORDER_STATUS,
  ORDER_PAYMENT_STATUS,
  NOTIFICATION_FROM_SELLER_195
}

final notificationHeadingValues = EnumValues({
  "Notification from seller_195":
      NotificationHeading.NOTIFICATION_FROM_SELLER_195,
  "Order Payment Status": NotificationHeading.ORDER_PAYMENT_STATUS,
  "Order Status": NotificationHeading.ORDER_STATUS
});

enum UserExternalIds { SELLER_195 }

final userExternalIdsValues =
    EnumValues({"[\"seller_195\"]": UserExternalIds.SELLER_195});

class Link {
  String? url;
  String label;
  bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
