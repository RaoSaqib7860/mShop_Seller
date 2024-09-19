class getProductSingleUserModel {
  int? id;
  String? name;
  Campaign? campaign;
  String? addedBy;
  int? sellerId;
  int? shopId;
  String? shopName;
  String? shopLogo;
  Campaign? category;
  List? stages;
  String? warranty;
  int? published;
  String? breadcrumb;
  BreadCrumbParts? breadCrumbParts;
  List<Variants>? variants;
  List<String>? photos;
  List<Taxes>? taxes;
  String? thumbnailImg;
  List? tags;
  String? priceHighLow;
  List<ChoiceOptions>? choiceOptions;
  List<Colors>? colors;
  bool? hasDiscount;
  String? discountType;
  String? discount;
  String? strokedPrice;
  String? mainPrice;
  int? minQty;
  String? shippingType;
  String? shippingCost;
  int? shippingDays;
  String? unit;
  String? cashOnDelivery;
  dynamic calculablePrice;
  String? currencySymbol;
  int? currentStock;
  int? rating;
  int? ratingCount;
  int? earnPoint;
  String? description;
  String? videoLink;
  Brand? brand;
  String? slug;
  bool? isInWishlist;
  bool? isInCart;
  String? link;

  getProductSingleUserModel(
      {this.id,
      this.name,
      this.campaign,
      this.addedBy,
      this.sellerId,
      this.shopId,
      this.shopName,
      this.shopLogo,
      this.category,
      this.stages,
      this.warranty,
      this.published,
      this.breadcrumb,
      this.breadCrumbParts,
      this.variants,
      this.photos,
      this.taxes,
      this.thumbnailImg,
      this.tags,
      this.priceHighLow,
      this.choiceOptions,
      this.colors,
      this.hasDiscount,
      this.discountType,
      this.discount,
      this.strokedPrice,
      this.mainPrice,
      this.minQty,
      this.shippingType,
      this.shippingCost,
      this.shippingDays,
      this.unit,
      this.cashOnDelivery,
      this.calculablePrice,
      this.currencySymbol,
      this.currentStock,
      this.rating,
      this.ratingCount,
      this.earnPoint,
      this.description,
      this.videoLink,
      this.brand,
      this.slug,
      this.isInWishlist,
      this.isInCart,
      this.link});

  getProductSingleUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    campaign = json['campaign'] != null
        ? new Campaign.fromJson(json['campaign'])
        : null;
    addedBy = json['added_by'];
    sellerId = json['seller_id'];
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    shopLogo = json['shop_logo'];
    category = json['category'] != null
        ? new Campaign.fromJson(json['category'])
        : null;
    stages = json['stages']??[];
    warranty = json['warranty'];
    published = json['published'];
    breadcrumb = json['breadcrumb'];
    breadCrumbParts = json['bread_crumb_parts'] != null
        ? new BreadCrumbParts.fromJson(json['bread_crumb_parts'])
        : null;
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    photos = json['photos'].cast<String>();
    if (json['taxes'] != null) {
      taxes = <Taxes>[];
      json['taxes'].forEach((v) {
        taxes!.add(new Taxes.fromJson(v));
      });
    }
    thumbnailImg = json['thumbnail_img'];
    if(json['tags']!=null && json['tags'] is List){
      tags =json['tags'] ??[];
    }else{
      tags=[];
    }
    priceHighLow = json['price_high_low'];
    if (json['choice_options'] != null) {
      choiceOptions = <ChoiceOptions>[];
      json['choice_options'].forEach((v) {
        choiceOptions!.add(new ChoiceOptions.fromJson(v));
      });
    }
    if (json['colors'] != null) {
      colors = <Colors>[];
      json['colors'].forEach((v) {
        colors!.add(new Colors.fromJson(v));
      });
    }
    hasDiscount = json['has_discount'];
    discountType = json['discount_type'];
    discount = json['discount'];
    strokedPrice = json['stroked_price'];
    mainPrice = json['main_price'];
    minQty = json['min_qty'];
    shippingType = json['shipping_type'];
    shippingCost =
        json['shipping_cost'] == null ? '' : json['shipping_cost'].toString();
    shippingDays = json['shipping_days'];
    unit = json['unit'];
    cashOnDelivery = json['cash_on_delivery'];
    calculablePrice = json['calculable_price'];
    currencySymbol = json['currency_symbol'];
    currentStock = json['current_stock'];
    rating = json['rating'];
    ratingCount = json['rating_count'];
    earnPoint = json['earn_point'];
    description = json['description'];
    videoLink = json['video_link'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    slug = json['slug'];
    isInWishlist = json['is_in_wishlist'];
    isInCart = json['is_in_cart'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.campaign != null) {
      data['campaign'] = this.campaign!.toJson();
    }
    data['added_by'] = this.addedBy;
    data['seller_id'] = this.sellerId;
    data['shop_id'] = this.shopId;
    data['shop_name'] = this.shopName;
    data['shop_logo'] = this.shopLogo;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['stages.dart'] = this.stages;
    data['warranty'] = this.warranty;
    data['published'] = this.published;
    data['breadcrumb'] = this.breadcrumb;
    if (this.breadCrumbParts != null) {
      data['bread_crumb_parts'] = this.breadCrumbParts!.toJson();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    data['photos'] = this.photos;
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.toJson()).toList();
    }
    data['thumbnail_img'] = this.thumbnailImg;
    if (this.tags != null ){
      data['tags'] = this.tags;
    }

    data['price_high_low'] = this.priceHighLow;
    if (this.choiceOptions != null) {
      data['choice_options'] =
          this.choiceOptions!.map((v) => v.toJson()).toList();
    }
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    data['has_discount'] = this.hasDiscount;
    data['discount_type'] = this.discountType;
    data['discount'] = this.discount;
    data['stroked_price'] = this.strokedPrice;
    data['main_price'] = this.mainPrice;
    data['min_qty'] = this.minQty;
    data['shipping_type'] = this.shippingType;
    data['shipping_cost'] = this.shippingCost;
    data['shipping_days'] = this.shippingDays;
    data['unit'] = this.unit;
    data['cash_on_delivery'] = this.cashOnDelivery;
    data['calculable_price'] = this.calculablePrice;
    data['currency_symbol'] = this.currencySymbol;
    data['current_stock'] = this.currentStock;
    data['rating'] = this.rating;
    data['rating_count'] = this.ratingCount;
    data['earn_point'] = this.earnPoint;
    data['description'] = this.description;
    data['video_link'] = this.videoLink;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['slug'] = this.slug;
    data['is_in_wishlist'] = this.isInWishlist;
    data['is_in_cart'] = this.isInCart;
    data['link'] = this.link;
    return data;
  }
}

class Campaign {
  int? id;
  String? name;

  Campaign({this.id, this.name});

  Campaign.fromJson(Map<String, dynamic> json) {
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

class BreadCrumbParts {
  String? categoryPath;
  int? categoryId;
  String? categoryName;
  String? productName;

  BreadCrumbParts(
      {this.categoryPath,
      this.categoryId,
      this.categoryName,
      this.productName});

  BreadCrumbParts.fromJson(Map<String, dynamic> json) {
    categoryPath = json['category_path'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_path'] = this.categoryPath;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['product_name'] = this.productName;
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
  Title? title;
  List<String>? options;

  ChoiceOptions({this.name, this.title, this.options});

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    data['options'] = this.options;
    return data;
  }
}

class Title {
  int? id;
  int? categoryId;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Null>? attributeTranslations;

  Title(
      {this.id,
      this.categoryId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.attributeTranslations});

  Title.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['attribute_translations'] != null) {
      attributeTranslations = <Null>[];
      // json['attribute_translations'].forEach((v) {
      //   attributeTranslations!.add(new Null.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // if (this.attributeTranslations != null) {
    //   data['attribute_translations'] =
    //       this.attributeTranslations!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Colors {
  int? id;
  String? name;
  String? code;

  Colors({this.id, this.name, this.code});

  Colors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
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

class ADDToCartObject {
  List<getProductSingleUserModel>? data = [];

  ADDToCartObject({this.data});

  ADDToCartObject.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <getProductSingleUserModel>[];
      json['data'].forEach((v) {
        data!.add(new getProductSingleUserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
