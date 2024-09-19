class GetAllProductOfCategories {
  List<Data>? data;
  Links? links;
  Meta? meta;
  bool? success;
  int? status;

  GetAllProductOfCategories(
      {this.data, this.links, this.meta, this.success, this.status});

  GetAllProductOfCategories.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? addedBy;
  int? sellerId;
  int? shopId;
  String? shopName;
  String? shopLogo;
  String? published;
  Category? category;
  List<Null>? variants;
  List<Null>? taxes;
  String? thumbnailImg;
  List<String>? tags;
  String? priceHighLow;
  List<Null>? choiceOptions;
  List<Null>? colors;
  bool? hasDiscount;
  String? discount;
  String? strokedPrice;
  String? mainPrice;
  String? calculablePrice;
  String? currencySymbol;
  int? currentStock;
  String? unit;
  double? rating;
  int? ratingCount;
  int? earnPoint;
  String? description;
  String? videoLink;
  Brand? brand;
  String? link;
  String? basePrice;
  String? baseDiscountedPrice;
  int? todaysDeal;
  int? featured;
  String? discountType;
  int? sales;
  Links? links;

  Data(
      {this.id,
      this.name,
      this.addedBy,
      this.sellerId,
      this.shopId,
      this.shopName,
      this.shopLogo,
      this.published,
      this.category,
      this.variants,
      this.taxes,
      this.thumbnailImg,
      this.tags,
      this.priceHighLow,
      this.choiceOptions,
      this.colors,
      this.hasDiscount,
      this.discount,
      this.strokedPrice,
      this.mainPrice,
      this.calculablePrice,
      this.currencySymbol,
      this.currentStock,
      this.unit,
      this.rating,
      this.ratingCount,
      this.earnPoint,
      this.description,
      this.videoLink,
      this.brand,
      this.link,
      this.basePrice,
      this.baseDiscountedPrice,
      this.todaysDeal,
      this.featured,
      this.discountType,
      this.sales,
      this.links});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    addedBy = json['added_by'];
    sellerId = json['seller_id'];
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    shopLogo = json['shop_logo'];
    published = json['published'].toString();
    // category = json['category'] != null
    //     ? new Category.fromJson(json['category'])
    //     : null;
    // if (json['variants'] != null) {
    //   variants = <Null>[];
    //   json['variants'].forEach((v) {
    //     variants!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['taxes'] != null) {
    //   taxes = <Null>[];
    //   json['taxes'].forEach((v) {
    //     taxes!.add(new Null.fromJson(v));
    //   });
    // }
    thumbnailImg = json['thumbnail_img'];
    //tags = json['tags'].cast<String>();
    priceHighLow = json['price_high_low'];
    // if (json['choice_options'] != null) {
    //   choiceOptions = <Null>[];
    //   json['choice_options'].forEach((v) {
    //     choiceOptions!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['colors'] != null) {
    //   colors = <Null>[];
    //   json['colors'].forEach((v) {
    //     colors!.add(new Null.fromJson(v));
    //   });
    // }
    hasDiscount = json['has_discount'];
    discount = json['discount'].toString();
    strokedPrice = json['stroked_price'];
    mainPrice = json['main_price'];
    calculablePrice = json['calculable_price'].toString();
    currencySymbol = json['currency_symbol'];
    currentStock = json['current_stock'];
    unit = json['unit'];
    rating = double.parse('${json['rating']??0.0}');
    ratingCount = json['rating_count'];
    earnPoint = json['earn_point'];
    description = json['description'] ?? "";
    videoLink = json['video_link'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    link = json['link'];
    basePrice = json['base_price'].toString();
    baseDiscountedPrice = json['base_discounted_price'].toString();
    todaysDeal = json['todays_deal'];
    featured = json['featured'];
    discountType = json['discount_type'];
    sales = json['sales'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['added_by'] = this.addedBy;
    data['seller_id'] = this.sellerId;
    data['shop_id'] = this.shopId;
    data['shop_name'] = this.shopName;
    data['shop_logo'] = this.shopLogo;
    data['published'] = this.published;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    // if (this.variants != null) {
    //   data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    // }
    // if (this.taxes != null) {
    //   data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    // }
    data['thumbnail_img'] = this.thumbnailImg;
    data['tags'] = this.tags;
    data['price_high_low'] = this.priceHighLow;
    // if (this.choiceOptions != null) {
    //   data['choice_options'] =
    //       this.choiceOptions!.map((v) => v.toJson()).toList();
    // }
    // if (this.colors != null) {
    //   data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    // }
    data['has_discount'] = this.hasDiscount;
    data['discount'] = this.discount;
    data['stroked_price'] = this.strokedPrice;
    data['main_price'] = this.mainPrice;
    data['calculable_price'] = this.calculablePrice;
    data['currency_symbol'] = this.currencySymbol;
    data['current_stock'] = this.currentStock;
    data['unit'] = this.unit;
    data['rating'] = this.rating;
    data['rating_count'] = this.ratingCount;
    data['earn_point'] = this.earnPoint;
    data['description'] = this.description;
    data['video_link'] = this.videoLink;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['link'] = this.link;
    data['base_price'] = this.basePrice;
    data['base_discounted_price'] = this.baseDiscountedPrice;
    data['todays_deal'] = this.todaysDeal;
    data['featured'] = this.featured;
    data['discount_type'] = this.discountType;
    data['sales'] = this.sales;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Brand {
  int? id;
  String? name;
  String? logo;

  Brand({this.id, this.name, this.logo});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}

// class Links {
//   String? details;
//   String? reviews;
//   String? related;
//
//   Links({this.details, this.reviews, this.related});
//
//   Links.fromJson(Map<String, dynamic> json) {
//     details = json['details'];
//     reviews = json['reviews'];
//     related = json['related'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['details'] = this.details;
//     data['reviews'] = this.reviews;
//     data['related'] = this.related;
//     return data;
//   }
// }

class LinksAdd {
  String? first;
  String? last;
  Null? prev;
  String? next;

  LinksAdd({this.first, this.last, this.prev, this.next});

  LinksAdd.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  dynamic perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.links,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
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
