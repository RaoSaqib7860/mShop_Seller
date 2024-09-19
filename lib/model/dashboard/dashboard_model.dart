import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';

DashBoard dashBoardFromJson(String str) => DashBoard.fromJson(json.decode(str));

String dashBoardToJson(DashBoard data) => json.encode(data.toJson());

class DashBoard {
  DashBoard({
    required this.result,
    required this.data,
  });

  bool result;
  Data data;

  factory DashBoard.fromJson(Map<String, dynamic> json) => DashBoard(
    result: json["result"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.productCount,
    required this.rating,
    required this.totalOrder,
    required this.totalSales,
    required this.categoryWiseProduct,
    required this.orders,
    required this.soldAmount,
    required this.verficationThumb,
    required this.products,
    required this.last7DaysSales,
    required this.salesToday,
    required this.salesThisWeek,
    required this.salesThisMonth,
    required this.salesThisYear,
    required this.salesAll,
    required this.salesRevenueData,
  });

  ProductCount productCount;
  Rating rating;
  ProductCount totalOrder;
  TotalSales totalSales;
  Map<String, CategoryWiseProduct> categoryWiseProduct;
  Orders orders;
  SoldAmount soldAmount;
  String verficationThumb;
  List<Product> products;
  Map<String, double> last7DaysSales;
  Sales salesToday;
  Sales salesThisWeek;
  Sales salesThisMonth;
  Sales salesThisYear;
  Sales salesAll;
  List<SalesRevenueDatum> salesRevenueData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    productCount: ProductCount.fromJson(json["product_count"]),
    rating: Rating.fromJson(json["rating"]),
    totalOrder: ProductCount.fromJson(json["total_order"]),
    totalSales: TotalSales.fromJson(json["total_sales"]),
    categoryWiseProduct:json["category_wise_product"] is List?{}: Map.from(json["category_wise_product"]).map((k, v) => MapEntry<String, CategoryWiseProduct>(k, CategoryWiseProduct.fromJson(v))),
    orders: Orders.fromJson(json["orders"]),
    soldAmount: SoldAmount.fromJson(json["sold_amount"]),
    verficationThumb: json["verfication_thumb"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    last7DaysSales:json["last_7_days_sales"] is List?{}: Map.from(json["last_7_days_sales"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    salesToday: Sales.fromJson(json["sales_today"]),
    salesThisWeek: Sales.fromJson(json["sales_this_week"]),
    salesThisMonth: Sales.fromJson(json["sales_this_month"]),
    salesThisYear: Sales.fromJson(json["sales_this_year"]),
    salesAll: Sales.fromJson(json["sales_all"]),
    salesRevenueData: List<SalesRevenueDatum>.from(json["sales_revenue_data"].map((x) => SalesRevenueDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_count": productCount.toJson(),
    "rating": rating.toJson(),
    "total_order": totalOrder.toJson(),
    "total_sales": totalSales.toJson(),
    "category_wise_product": Map.from(categoryWiseProduct).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "orders": orders.toJson(),
    "sold_amount": soldAmount.toJson(),
    "verfication_thumb": verficationThumb,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "last_7_days_sales": Map.from(last7DaysSales).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "sales_today": salesToday.toJson(),
    "sales_this_week": salesThisWeek.toJson(),
    "sales_this_month": salesThisMonth.toJson(),
    "sales_this_year": salesThisYear.toJson(),
    "sales_all": salesAll.toJson(),
    "sales_revenue_data": List<dynamic>.from(salesRevenueData.map((x) => x.toJson())),
  };
}

class CategoryWiseProduct {
  CategoryWiseProduct({this.name, this.count, this.color});

  String? name;
  int? count;
  Color? color;

  factory CategoryWiseProduct.fromJson(Map<String, dynamic> json) =>
      CategoryWiseProduct(
          name: json["name"],
          count: json["count"],
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0));

  Map<String, dynamic> toJson() => {
    "name": name,
    "count": count,
  };
}

class Orders {
  Orders({
    required this.today,
    required this.thisWeek,
    required this.thisMonth,
    required this.thisYear,
  });

  ThisMonth today;
  ThisMonth thisWeek;
  ThisMonth thisMonth;
  ThisMonth thisYear;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    today: ThisMonth.fromJson(json["today"]),
    thisWeek: ThisMonth.fromJson(json["this_week"]),
    thisMonth: ThisMonth.fromJson(json["this_month"]),
    thisYear: ThisMonth.fromJson(json["this_year"]),
  );

  Map<String, dynamic> toJson() => {
    "today": today.toJson(),
    "this_week": thisWeek.toJson(),
    "this_month": thisMonth.toJson(),
    "this_year": thisYear.toJson(),
  };
}

class ThisMonth {
  ThisMonth({
    required this.newOrder,
    required this.cancelled,
    required this.onDelivery,
    required this.delivered,
  });

  int newOrder;
  int cancelled;
  int onDelivery;
  int delivered;

  factory ThisMonth.fromJson(Map<String, dynamic> json) => ThisMonth(
    newOrder: json["new_order"],
    cancelled: json["cancelled"],
    onDelivery: json["on_delivery"],
    delivered: json["Delivered"],
  );

  Map<String, dynamic> toJson() => {
    "new_order": newOrder,
    "cancelled": cancelled,
    "on_delivery": onDelivery,
    "Delivered": delivered,
  };
}

class ProductCount {
  ProductCount({
    required this.label,
    required this.value,
  });

  String label;
  int value;

  factory ProductCount.fromJson(Map<String, dynamic> json) => ProductCount(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.slug,
    this.rating,
    required this.thumbnail,
  });

  int id;
  String name;
  String price;
  String slug;
  int? rating;
  String thumbnail;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    slug: json["slug"],
    rating: json["rating"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "slug": slug,
    "rating": rating,
    "thumbnail": thumbnail,
  };
}

class Rating {
  Rating({
    this.label,
    this.value,
  });

  String? label;
  var value;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    label: json["label"],
    value: json["value"]??'0',
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}

class Value {
  Value({
    required this.rating,
    this.user,
  });

  double rating;
  dynamic user;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    rating: json["rating"]?.toDouble(),
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "user": user,
  };
}

class Sales {
  Sales({
    required this.revenue,
    required this.count,
  });

  int revenue;
  int count;

  factory Sales.fromJson(Map<String, dynamic> json) => Sales(
    revenue: json["revenue"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "revenue": revenue,
    "count": count,
  };
}

class SalesRevenueDatum {
  SalesRevenueDatum({
    required this.revenue,
    required this.month,
    required this.year,
  });

  int revenue;
  String month;
  int year;

  factory SalesRevenueDatum.fromJson(Map<String, dynamic> json) => SalesRevenueDatum(
    revenue: json["revenue"],
    month: json["month"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "revenue": revenue,
    "month": month,
    "year": year,
  };
}

class SoldAmount {
  SoldAmount({
    required this.currentMonth,
    required this.lastMonth,
  });

  String currentMonth;
  String lastMonth;

  factory SoldAmount.fromJson(Map<String, dynamic> json) => SoldAmount(
    currentMonth: json["current_month"],
    lastMonth: json["last_month"],
  );

  Map<String, dynamic> toJson() => {
    "current_month": currentMonth,
    "last_month": lastMonth,
  };
}

class TotalSales {
  TotalSales({
    required this.label,
    required this.value,
  });

  String label;
  String value;

  factory TotalSales.fromJson(Map<String, dynamic> json) => TotalSales(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}

