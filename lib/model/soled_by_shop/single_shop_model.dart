class GetAllProductsByShop {
  List<Data>? data;
  Links? links;
  Meta? meta;
  bool? success;
  int? status;

  GetAllProductsByShop(
      {this.data, this.links, this.meta, this.success, this.status});

  GetAllProductsByShop.fromJson(Map<String, dynamic> json) {
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
  List? stages;
  List<Variants>? variants;
  List<Taxes>? taxes;
  String? thumbnailImg;
  List<String>? tags;
  String? priceHighLow;
  List<ChoiceOptions>? choiceOptions;
  List<String>? colors;
  bool? hasDiscount;
  int? discount;
  String? strokedPrice;
  String? mainPrice;
  dynamic calculablePrice;
  String? currencySymbol;
  int? currentStock;
  String? unit;
  int? rating;
  int? ratingCount;
  int? earnPoint;
  String? description;
  String? videoLink;
  Brand? brand;
  String? link;
  dynamic basePrice;
  dynamic baseDiscountedPrice;
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
      this.stages,
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
    published = json['published'];
    // category = json['category'] != null
    //     ? new Category.fromJson(json['category'])
    //     : null;
    stages = json['stages'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    if (json['taxes'] != null) {
      taxes = <Taxes>[];
      json['taxes'].forEach((v) {
        taxes!.add(new Taxes.fromJson(v));
      });
    }
    thumbnailImg = json['thumbnail_img'];
    tags = json['tags'] is List ? json['tags'].cast<String>() : [];
    priceHighLow = json['price_high_low'];
    if (json['choice_options'] != null) {
      choiceOptions = <ChoiceOptions>[];
      json['choice_options'].forEach((v) {
        choiceOptions!.add(new ChoiceOptions.fromJson(v));
      });
    }
    colors = json['colors'].cast<String>();
    hasDiscount = json['has_discount'];
    discount = json['discount'];
    strokedPrice = json['stroked_price'];
    mainPrice = json['main_price'];
    calculablePrice = json['calculable_price'];
    currencySymbol = json['currency_symbol'];
    currentStock = json['current_stock'];
    unit = json['unit'];
    rating = json['rating'];
    ratingCount = json['rating_count'];
    earnPoint = json['earn_point'];
    description = json['description'];
    videoLink = json['video_link'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    link = json['link'];
    basePrice = json['base_price'];
    baseDiscountedPrice = json['base_discounted_price'];
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
    data['stages'] = this.stages;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    data['thumbnail_img'] = this.thumbnailImg;
    data['tags'] = this.tags;
    data['price_high_low'] = this.priceHighLow;
    if (this.choiceOptions != null) {
      data['choice_options'] =
          this.choiceOptions!.map((v) => v.toJson()).toList();
    }
    data['colors'] = this.colors;
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

class Variants {
  String? variant;
  String? sku;
  int? qty;
  int? price;
  String? path;

  Variants({this.variant, this.sku, this.qty, this.price, this.path});

  Variants.fromJson(Map<String, dynamic> json) {
    variant = json['variant'];
    sku = json['sku'];
    qty = json['qty'];
    price = json['price'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant'] = this.variant;
    data['sku'] = this.sku;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['path'] = this.path;
    return data;
  }
}

class Taxes {
  int? id;
  int? productId;
  int? tax;
  int? taxId;
  String? taxType;

  Taxes({this.id, this.productId, this.tax, this.taxId, this.taxType});

  Taxes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    tax = json['tax'];
    taxId = json['tax_id'];
    taxType = json['tax_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['tax'] = this.tax;
    data['tax_id'] = this.taxId;
    data['tax_type'] = this.taxType;
    return data;
  }
}

class ChoiceOptions {
  String? name;
  String? title;
  List<String>? options;

  ChoiceOptions({this.name, this.title, this.options});

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['options'] = this.options;
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

class Links {
  String? details;
  String? reviews;
  String? related;

  Links({this.details, this.reviews, this.related});

  Links.fromJson(Map<String, dynamic> json) {
    details = json['details'];
    reviews = json['reviews'];
    related = json['related'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['details'] = this.details;
    data['reviews'] = this.reviews;
    data['related'] = this.related;
    return data;
  }
}

class Linksed {
  String? first;
  String? last;
  Null? prev;
  Null? next;

  Linksed({this.first, this.last, this.prev, this.next});

  Linksed.fromJson(Map<String, dynamic> json) {
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
  var perPage;
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

class Linkse {
  String? url;
  String? label;
  bool? active;

  Linkse({this.url, this.label, this.active});

  Linkse.fromJson(Map<String, dynamic> json) {
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
