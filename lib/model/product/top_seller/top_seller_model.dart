import 'dart:developer';

class TopBestSellingProduct {
  List<Data>? data = [];
  bool? success;
  int? status;
  List<Data>? data1 = [];
  List<Data>? data2 = [];

  TopBestSellingProduct({this.data, this.success, this.status,this.data1,this.data2});

  TopBestSellingProduct.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
    log('result is = ${data!.length}');
    data!.forEach((element) {
      int index = data!.indexOf(element);
      if (index.isEven) {
        data1!.add(element);
      } else {
        data2!.add(element);
      }
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? thumbnailImg;
  bool? hasDiscount;
  String? discount;
  String? strokedPrice;
  String? mainPrice;
  int? rating;
  int? sales;
  Links? links;

  Data(
      {this.id,
        this.name,
        this.thumbnailImg,
        this.hasDiscount,
        this.discount,
        this.strokedPrice,
        this.mainPrice,
        this.rating,
        this.sales,
        this.links});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnailImg = json['thumbnail_img'];
    hasDiscount = json['has_discount'];
    discount = json['discount'];
    strokedPrice = json['stroked_price'];
    mainPrice = json['main_price'];
    rating = json['rating'];
    sales = json['sales'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnail_img'] = this.thumbnailImg;
    data['has_discount'] = this.hasDiscount;
    data['discount'] = this.discount;
    data['stroked_price'] = this.strokedPrice;
    data['main_price'] = this.mainPrice;
    data['rating'] = this.rating;
    data['sales'] = this.sales;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class Links {
  String? details;

  Links({this.details});

  Links.fromJson(Map<String, dynamic> json) {
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['details'] = this.details;
    return data;
  }
}
