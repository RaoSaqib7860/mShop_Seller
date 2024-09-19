class MyOrderModel {
  List<Data>? data;
  //Links? links;
  Meta? meta;

  MyOrderModel({this.data, this.meta});

  MyOrderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    //links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    // if (this.links != null) {
    //   data['links'] = this.links!.toJson();
    // }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  ShippingAddress? shippingAddress;
  String? orderNumber;
  int? numberOfProducts;
  int? deliveredBySeller;
  int? deliveredByHousy;
  DeliveryBoy? deliveryBoy;
  PickupPoint? pickupPoint;
  String? grandTotal;
  String? deliveryStatus;
  String? paymentMethod;
  String? additionalInfo;
  String? invoice;
  List<CombineOrders>? combineOrders;
  String? total;
  String? orderDate;
  String? tax;
  String? shippingCost;
  String? paymentStatus;

  Data(
      {this.id,
      this.shippingAddress,
      this.orderNumber,
      this.numberOfProducts,
      this.deliveredBySeller,
      this.deliveredByHousy,
      this.deliveryBoy,
      this.pickupPoint,
      this.grandTotal,
      this.deliveryStatus,
      this.paymentMethod,
      this.additionalInfo,
      this.invoice,
      this.combineOrders,
      this.total,
      this.orderDate,
      this.tax,
      this.shippingCost,
      this.paymentStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shippingAddress =
        json['shipping_address'] != null && json['shipping_address'] is Map
            ? new ShippingAddress.fromJson(json['shipping_address'])
            : null;
    orderNumber = json['order_number'];
    numberOfProducts = json['number_of_products'];
    deliveredBySeller = json['delivered_by_seller'];
    deliveredByHousy = json['delivered_by_housy'];
    deliveryBoy = json['delivery_boy'] != null
        ? new DeliveryBoy.fromJson(json['delivery_boy'])
        : null;
    pickupPoint = json['pickup_point'] != null
        ? new PickupPoint.fromJson(json['pickup_point'])
        : null;
    grandTotal = json['grand_total'];
    deliveryStatus = json['delivery_status'];
    paymentMethod = json['payment_method'];
    additionalInfo = json['additional_info'];
    invoice = json['invoice'];
    if (json['combine_orders'] != null) {
      combineOrders = <CombineOrders>[];
      json['combine_orders'].forEach((v) {
        combineOrders!.add(new CombineOrders.fromJson(v));
      });
    }
    total = json['total'];
    orderDate = json['order_date'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    data['order_number'] = this.orderNumber;
    data['number_of_products'] = this.numberOfProducts;
    data['delivered_by_seller'] = this.deliveredBySeller;
    data['delivered_by_housy'] = this.deliveredByHousy;
    if (this.deliveryBoy != null) {
      data['delivery_boy'] = this.deliveryBoy!.toJson();
    }
    if (this.pickupPoint != null) {
      data['pickup_point'] = this.pickupPoint!.toJson();
    }
    data['grand_total'] = this.grandTotal;
    data['delivery_status'] = this.deliveryStatus;
    data['payment_method'] = this.paymentMethod;
    data['additional_info'] = this.additionalInfo;
    data['invoice'] = this.invoice;
    if (this.combineOrders != null) {
      data['combine_orders'] =
          this.combineOrders!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['order_date'] = this.orderDate;
    data['tax'] = this.tax;
    data['shipping_cost'] = this.shippingCost;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}

class ShippingAddress {
  String? addressTitle;
  String? name;
  String? email;
  String? address;
  String? country;
  String? state;
  String? city;
  String? postalCode;
  String? phone;
  String? location;

  ShippingAddress(
      {this.addressTitle,
      this.name,
      this.email,
      this.address,
      this.country,
      this.state,
      this.city,
      this.postalCode,
      this.phone,
      this.location});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    addressTitle = json['address_title'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    postalCode = json['postal_code'] ?? '';
    phone = json['phone'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_title'] = this.addressTitle;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['phone'] = this.phone;
    data['location'] = this.location;
    return data;
  }
}

class DeliveryBoy {
  String? name;
  String? email;
  String? phone;

  DeliveryBoy({this.name, this.email, this.phone});

  DeliveryBoy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class PickupPoint {
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

  PickupPoint(
      {this.id,
      this.shopVerificationId,
      this.shopId,
      this.warehouseName,
      this.warehouseAddress,
      this.warehouseCountry,
      this.warehouseCity,
      this.warehouseContact,
      this.warehouseState,
      this.warehouseGoogleLocation});

  PickupPoint.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class CombineOrders {
  String? productTitle;
  String? productSlug;
  String? link;
  String? thumbnail;

  CombineOrders(
      {this.productTitle, this.productSlug, this.link, this.thumbnail});

  CombineOrders.fromJson(Map<String, dynamic> json) {
    productTitle = json['product_title'];
    productSlug = json['product_slug'];
    link = json['link'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_title'] = this.productTitle;
    data['product_slug'] = this.productSlug;
    data['link'] = this.link;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  //List<Links>? links;
  String? path;
  String? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      //this.links,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    // if (json['links'] != null) {
    //   links = <Links>[];
    //   json['links'].forEach((v) {
    //     links!.add(new Links.fromJson(v));
    //   });
    // }
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
    // if (this.links != null) {
    //   data['links'] = this.links!.map((v) => v.toJson()).toList();
    // }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
