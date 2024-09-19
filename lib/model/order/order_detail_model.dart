class OrderDetailModel {
  Data? data;

  OrderDetailModel({this.data});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? orderCode;
  int? deliveredBySeller;
  int? deliveredByHousy;
  String? total;
  String? orderDate;
  String? paymentStatus;
  String? paymentType;
  String? deliveryStatus;
  String? shippingType;
  String? paymentMethod;
  ShippingAddress? shippingAddress;
  String? shippingCost;
  String? subtotal;
  String? couponDiscount;
  String? tax;
  String? invoiceLink;
  List<OrderItems>? orderItems;
  PickupPoint? pickup_point;
  DeliveryCompanyDetail? delivery_company_detail;
  Delivery_package? delivery_package;
  String? service_fee;
  Data(
      {this.orderCode,
      this.deliveredBySeller,
      this.deliveredByHousy,
      this.total,
      this.orderDate,
      this.paymentStatus,
      this.paymentType,
      this.deliveryStatus,
      this.shippingType,
      this.paymentMethod,
      this.shippingAddress,
      this.shippingCost,
      this.subtotal,
      this.couponDiscount,
      this.tax,
      this.invoiceLink,
      this.orderItems,
      this.pickup_point,
      this.delivery_company_detail,
      this.service_fee,
      this.delivery_package});

  Data.fromJson(Map<String, dynamic> json) {
    orderCode = json['order_code'];
    service_fee = json['service_fee'];
    deliveredBySeller = json['delivered_by_seller'];
    deliveredByHousy = json['delivered_by_housy'];
    total = json['total'];
    orderDate = json['order_date'];
    paymentStatus = json['payment_status'];
    paymentType = json['payment_type'];
    deliveryStatus = json['delivery_status'];
    shippingType = json['shipping_type'];
    paymentMethod = json['payment_method'];
    shippingAddress =
        json['shipping_address'] != null && json['shipping_address'] is Map
            ? new ShippingAddress.fromJson(json['shipping_address'])
            : null;
    delivery_package = json['delivery_package'] != null
        ? new Delivery_package.fromJson(json['delivery_package'])
        : null;
    pickup_point = json['pickup_point'] != null
        ? new PickupPoint.fromJson(json['pickup_point'])
        : null;
    delivery_company_detail = json['delivery_company_detail'] != null
        ? new DeliveryCompanyDetail.fromJson(json['delivery_company_detail'])
        : null;
    shippingCost = json['shipping_cost'];
    subtotal = json['subtotal'];
    couponDiscount = json['coupon_discount'];
    tax = json['tax'];
    invoiceLink = json['invoice_link'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_code'] = this.orderCode;
    data['delivered_by_seller'] = this.deliveredBySeller;
    data['delivered_by_housy'] = this.deliveredByHousy;
    data['total'] = this.total;
    data['order_date'] = this.orderDate;
    data['payment_status'] = this.paymentStatus;
    data['payment_type'] = this.paymentType;
    data['delivery_status'] = this.deliveryStatus;
    data['shipping_type'] = this.shippingType;
    data['payment_method'] = this.paymentMethod;
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    data['shipping_cost'] = this.shippingCost;
    data['subtotal'] = this.subtotal;
    data['coupon_discount'] = this.couponDiscount;
    data['tax'] = this.tax;
    data['invoice_link'] = this.invoiceLink;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingAddress {
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
      {this.name,
      this.email,
      this.address,
      this.country,
      this.state,
      this.city,
      this.location,
      this.postalCode,
      this.phone});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['phone'] = this.phone;
    return data;
  }
}

class OrderItems {
  String? name;
  String? description;
  String? deliveryStatus;
  String? shippingType;
  int? qTY;
  String? price;
  String? totalPrice;
  String? productSlug;
  String? link;
  String? thumbnail;

  OrderItems(
      {this.name,
      this.description,
      this.deliveryStatus,
      this.shippingType,
      this.qTY,
      this.price,
      this.totalPrice,
      this.productSlug,
      this.link,
      this.thumbnail});

  OrderItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'].toString();
    deliveryStatus = json['delivery_status'];
    shippingType = json['shipping_type'];
    qTY = json['QTY'];
    price = json['price'];
    totalPrice = json['total_price'];
    productSlug = json['product_slug'];
    link = json['link'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['delivery_status'] = this.deliveryStatus;
    data['shipping_type'] = this.shippingType;
    data['QTY'] = this.qTY;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['product_slug'] = this.productSlug;
    data['link'] = this.link;
    data['thumbnail'] = this.thumbnail;
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

class DeliveryCompanyDetail {
  String? name;
  String? email;
  String? phone;

  DeliveryCompanyDetail({this.name, this.email, this.phone});

  DeliveryCompanyDetail.fromJson(Map<String, dynamic> json) {
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

class Delivery_package {
  int? id;
  String? title;

  Delivery_package({this.id, this.title});

  Delivery_package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
