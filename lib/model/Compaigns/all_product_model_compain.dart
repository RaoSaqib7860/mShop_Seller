import 'dart:convert';

GetAllProductModelsCompain GetAllProductModelsCompainFromJson(String str) =>
    GetAllProductModelsCompain.fromJson(json.decode(str));

String GetAllProductModelsCompainToJson(GetAllProductModelsCompain data) =>
    json.encode(data.toJson());

class GetAllProductModelsCompain {
  List<Datum> data;
  GetAllProductModelsCompainLinks links;
  Meta meta;
  bool success;
  int status;

  GetAllProductModelsCompain({
    required this.data,
    required this.links,
    required this.meta,
    required this.success,
    required this.status,
  });

  factory GetAllProductModelsCompain.fromJson(Map<String, dynamic> json) =>
      GetAllProductModelsCompain(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: GetAllProductModelsCompainLinks.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
    "success": success,
    "status": status,
  };
}

class Datum {
  int id;
  String? name;
  AddedBy? addedBy;
  int? sellerId;
  Campaign? campaign;
  int? shopId;
  String? shopName;
  String? shopLogo;
  Published? published;
  String? breadcrumb;
  dynamic breadCrumbParts;
  dynamic category;
  List? stages;
  List<Variant> variants;
  List<Tax> taxes;
  String? thumbnailImg;
  dynamic tags;
  String? priceHighLow;
  List<ChoiceOption> choiceOptions;
  List<String> colors;
  bool hasDiscount;
  int discount;
  String strokedPrice;
  String mainPrice;
  double calculablePrice;
  CurrencySymbol currencySymbol;
  int currentStock;
  String unit;
  double rating;
  int ratingCount;
  int earnPoint;
  String? description;
  VideoLink? videoLink;
  Brand brand;
  String slug;
  String link;
  double basePrice;
  double baseDiscountedPrice;
  int todaysDeal;
  int featured;
  DiscountType? discountType;
  int sales;
  bool isInWishlist;
  bool isInCart;
  DatumLinks links;

  Datum({
    required this.id,
    required this.name,
    required this.addedBy,
    required this.sellerId,
    this.campaign,
    required this.shopId,
    required this.shopName,
    required this.shopLogo,
    required this.published,
    required this.breadcrumb,
    required this.breadCrumbParts,
    required this.category,
    required this.stages,
    required this.variants,
    required this.taxes,
    required this.thumbnailImg,
    this.tags,
    required this.priceHighLow,
    required this.choiceOptions,
    required this.colors,
    required this.hasDiscount,
    required this.discount,
    required this.strokedPrice,
    required this.mainPrice,
    required this.calculablePrice,
    required this.currencySymbol,
    required this.currentStock,
    required this.unit,
    required this.rating,
    required this.ratingCount,
    required this.earnPoint,
    this.description,
    required this.videoLink,
    required this.brand,
    required this.slug,
    required this.link,
    required this.basePrice,
    required this.baseDiscountedPrice,
    required this.todaysDeal,
    required this.featured,
    this.discountType,
    required this.sales,
    required this.isInWishlist,
    required this.isInCart,
    required this.links,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    addedBy: addedByValues.map[json["added_by"]]!,
    sellerId: json["seller_id"],
    campaign: json["campaign"] == null
        ? null
        : Campaign.fromJson(json["campaign"]),
    shopId: json["shop_id"],
    shopName: json["shop_name"] ?? '',
    shopLogo: json["shop_logo"],
    published: publishedValues.map[json["published"]]!,
    breadcrumb: json["breadcrumb"],
    breadCrumbParts: json["bread_crumb_parts"],
    category: json["category"],
    stages: json["stages"],
    variants: List<Variant>.from(
        json["variants"].map((x) => Variant.fromJson(x))),
    taxes: List<Tax>.from(json["taxes"].map((x) => Tax.fromJson(x))),
    thumbnailImg: json["thumbnail_img"],
    tags: json["tags"],
    priceHighLow: json["price_high_low"],
    choiceOptions: List<ChoiceOption>.from(
        json["choice_options"].map((x) => ChoiceOption.fromJson(x))),
    colors: List<String>.from(json["colors"].map((x) => x)),
    hasDiscount: json["has_discount"],
    discount: json["discount"],
    strokedPrice: json["stroked_price"],
    mainPrice: json["main_price"],
    calculablePrice: json["calculable_price"]?.toDouble(),
    currencySymbol: currencySymbolValues.map[json["currency_symbol"]]!,
    currentStock: json["current_stock"],
    unit: json["unit"],
    rating: double.parse('${json["rating"]}'),
    ratingCount: json["rating_count"],
    earnPoint: json["earn_point"],
    description: json["description"],
    videoLink: json["video_link"] == null
        ? null
        : videoLinkValues.map[json["video_link"]]!,
    brand: Brand.fromJson(json["brand"]),
    slug: json["slug"],
    link: json["link"],
    basePrice: json["base_price"]?.toDouble(),
    baseDiscountedPrice: json["base_discounted_price"]?.toDouble(),
    todaysDeal: json["todays_deal"],
    featured: json["featured"],
    discountType: discountTypeValues.map[json["discount_type"] ?? ''],
    sales: json["sales"],
    isInWishlist: json["is_in_wishlist"],
    isInCart: json["is_in_cart"],
    links: DatumLinks.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "added_by": addedByValues.reverse[addedBy],
    "seller_id": sellerId,
    "campaign": campaign?.toJson(),
    "shop_id": shopId,
    "shop_name": shopNameValues.reverse[shopName],
    "shop_logo": shopLogo,
    "published": publishedValues.reverse[published],
    "breadcrumb": breadcrumb,
    "bread_crumb_parts": breadCrumbParts,
    "category": category,
    "stages": stages,
    "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
    "taxes": List<dynamic>.from(taxes.map((x) => x.toJson())),
    "thumbnail_img": thumbnailImg,
    "tags": tags,
    "price_high_low": priceHighLow,
    "choice_options":
    List<dynamic>.from(choiceOptions.map((x) => x.toJson())),
    "colors": List<dynamic>.from(colors.map((x) => x)),
    "has_discount": hasDiscount,
    "discount": discount,
    "stroked_price": strokedPrice,
    "main_price": mainPrice,
    "calculable_price": calculablePrice,
    "currency_symbol": currencySymbolValues.reverse[currencySymbol],
    "current_stock": currentStock,
    "unit": unit,
    "rating": rating,
    "rating_count": ratingCount,
    "earn_point": earnPoint,
    "description": description,
    "video_link": videoLinkValues.reverse[videoLink],
    "brand": brand.toJson(),
    "slug": slug,
    "link": link,
    "base_price": basePrice,
    "base_discounted_price": baseDiscountedPrice,
    "todays_deal": todaysDeal,
    "featured": featured,
    "discount_type": discountTypeValues.reverse[discountType],
    "sales": sales,
    "is_in_wishlist": isInWishlist,
    "is_in_cart": isInCart,
    "links": links.toJson(),
  };
}

enum AddedBy { SELLER }

final addedByValues = EnumValues({"seller": AddedBy.SELLER});

class Brand {
  int id;
  Name? name;
  String logo;

  Brand({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    name: nameValues.map[json["name"]] ?? null,
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "logo": logo,
  };
}

enum Name {
  RAK_CEMENT,
  EMPTY,
  EMIRATES_CEMENT_FACTORY,
  IKEA,
  HB2,
  FUJAIRAH_CEMENT_INDUSTRIES
}

final nameValues = EnumValues({
  "Emirates Cement Factory": Name.EMIRATES_CEMENT_FACTORY,
  "": Name.EMPTY,
  "Fujairah Cement Industries": Name.FUJAIRAH_CEMENT_INDUSTRIES,
  "HB2": Name.HB2,
  "IKEA": Name.IKEA,
  "RAK Cement": Name.RAK_CEMENT
});

class BreadCrumbPartsClass {
  CategoryPath categoryPath;
  int categoryId;
  String categoryName;
  String productName;

  BreadCrumbPartsClass({
    required this.categoryPath,
    required this.categoryId,
    required this.categoryName,
    required this.productName,
  });

  factory BreadCrumbPartsClass.fromJson(Map<String, dynamic> json) =>
      BreadCrumbPartsClass(
        categoryPath: categoryPathValues.map[json["category_path"]]!,
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        productName: json["product_name"],
      );

  Map<String, dynamic> toJson() => {
    "category_path": categoryPathValues.reverse[categoryPath],
    "category_id": categoryId,
    "category_name": categoryName,
    "product_name": productName,
  };
}

enum CategoryPath { PRODUCTS_CATEGORY }

final categoryPathValues =
EnumValues({"products/category/": CategoryPath.PRODUCTS_CATEGORY});

class Campaign {
  int id;
  String name;

  Campaign({
    required this.id,
    required this.name,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class CategoryClass {
  int id;
  String name;
  int? parentId;
  ParentName? parentName;

  CategoryClass({
    required this.id,
    required this.name,
    this.parentId,
    this.parentName,
  });

  factory CategoryClass.fromJson(Map<String, dynamic> json) => CategoryClass(
    id: json["id"],
    name: json["name"],
    parentId: json["parent_id"],
    parentName: parentNameValues.map[json["parent_name"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent_id": parentId,
    "parent_name": parentNameValues.reverse[parentName],
  };
}

enum ParentName { CONSTRUCTION, PAINT, BLOCKS }

final parentNameValues = EnumValues({
  "Blocks": ParentName.BLOCKS,
  "Construction": ParentName.CONSTRUCTION,
  "Paint": ParentName.PAINT
});

class ChoiceOption {
  String name;
  String title;
  List<Option>? options;

  ChoiceOption({
    required this.name,
    required this.title,
    required this.options,
  });

  factory ChoiceOption.fromJson(Map<String, dynamic> json) => ChoiceOption(
    name: json["name"],
    title: json["title"] ?? '',
    options: [],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "title": title,
    "options":
    List<dynamic>.from(options!.map((x) => optionValues.reverse[x])),
  };
}

enum Option { LARGE, MEDIUM, SMALL }

final optionValues = EnumValues(
    {"Large": Option.LARGE, "Medium": Option.MEDIUM, "Small": Option.SMALL});

enum CurrencySymbol { AED }

final currencySymbolValues = EnumValues({"AED": CurrencySymbol.AED});

enum DiscountType { FLAT, AMOUNT, PERCENT, NULL }

final discountTypeValues = EnumValues({
  "amount": DiscountType.AMOUNT,
  "flat": DiscountType.FLAT,
  "null": DiscountType.NULL,
  "percent": DiscountType.PERCENT
});

class DatumLinks {
  String details;
  String reviews;
  String related;

  DatumLinks({
    required this.details,
    required this.reviews,
    required this.related,
  });

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
    details: json["details"],
    reviews: json["reviews"],
    related: json["related"],
  );

  Map<String, dynamic> toJson() => {
    "details": details,
    "reviews": reviews,
    "related": related,
  };
}

enum Published { YES, NO }

final publishedValues = EnumValues({"No": Published.NO, "Yes": Published.YES});

enum ShopName { LOOPS_STORE }

final shopNameValues = EnumValues({"Loops Store": ShopName.LOOPS_STORE});

class TagClass {
  String value;

  TagClass({
    required this.value,
  });

  factory TagClass.fromJson(Map<String, dynamic> json) => TagClass(
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
  };
}

class Tax {
  int id;
  int productId;
  int tax;
  int taxId;
  TaxType taxType;

  Tax({
    required this.id,
    required this.productId,
    required this.tax,
    required this.taxId,
    required this.taxType,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
    id: json["id"],
    productId: json["product_id"],
    tax: json["tax"],
    taxId: json["tax_id"],
    taxType: taxTypeValues.map[json["tax_type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "tax": tax,
    "tax_id": taxId,
    "tax_type": taxTypeValues.reverse[taxType],
  };
}

enum TaxType { PERCENT, TAX_TYPE_PERCENT }

final taxTypeValues = EnumValues(
    {"percent": TaxType.PERCENT, "[percent]": TaxType.TAX_TYPE_PERCENT});

class Variant {
  String variant;
  String? sku;
  int qty;
  int price;
  String path;

  Variant({
    required this.variant,
    this.sku,
    required this.qty,
    required this.price,
    required this.path,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    variant: json["variant"],
    sku: json["sku"],
    qty: json["qty"],
    price: json["price"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "variant": variant,
    "sku": sku,
    "qty": qty,
    "price": price,
    "path": path,
  };
}

enum VideoLink { EMPTY, NULL }

final videoLinkValues =
EnumValues({"": VideoLink.EMPTY, "null": VideoLink.NULL});

class GetAllProductModelsCompainLinks {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  GetAllProductModelsCompainLinks({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  factory GetAllProductModelsCompainLinks.fromJson(Map<String, dynamic> json) =>
      GetAllProductModelsCompainLinks(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  String perPage;
  int to;
  int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

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
