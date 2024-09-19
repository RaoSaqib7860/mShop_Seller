class PaymentSentModel {
  bool? result;
  List<Data>? data;

  PaymentSentModel({this.result, this.data});

  PaymentSentModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? paidTo;
  dynamic amountPaid;
  String? order_code;
  String? paymentMethod;
  String? paymentReceipt;
  OrderDetail? orderDetail;
  String? paymentVerified;
  DeliveryBoy? deliveryBoy;
  PickupPoint? pickupPoint;

  Data(
      {this.id,
      this.paidTo,
      this.amountPaid,
      this.order_code,
      this.paymentMethod,
      this.paymentReceipt,
      this.orderDetail,
      this.paymentVerified,
      this.deliveryBoy,
      this.pickupPoint});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paidTo = json['paid_to'];
    order_code = json['order_code'];
    amountPaid = json['amount_paid'];
    paymentMethod = json['payment_method'];
    paymentReceipt = json['payment_receipt'];
    orderDetail = json['order_detail'] != null
        ? new OrderDetail.fromJson(json['order_detail'])
        : null;
    paymentVerified = json['payment_verified'];
    deliveryBoy = json['delivery_boy'] != null
        ? new DeliveryBoy.fromJson(json['delivery_boy'])
        : null;
    pickupPoint = json['pickup_point'] != null
        ? new PickupPoint.fromJson(json['pickup_point'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['paid_to'] = this.paidTo;
    data['amount_paid'] = this.amountPaid;
    data['payment_method'] = this.paymentMethod;
    data['payment_receipt'] = this.paymentReceipt;
    if (this.orderDetail != null) {
      data['order_detail'] = this.orderDetail!.toJson();
    }
    data['payment_verified'] = this.paymentVerified;
    if (this.deliveryBoy != null) {
      data['delivery_boy'] = this.deliveryBoy!.toJson();
    }
    if (this.pickupPoint != null) {
      data['pickup_point'] = this.pickupPoint!.toJson();
    }
    return data;
  }
}

class OrderDetail {
  int? id;
  int? orderId;
  int? sellerId;
  int? productId;
  String? productName;
  String? thumbnailImg;
  String? variation;
  int? price;
  dynamic tax;
  int? shippingCost;
  int? quantity;
  String? paymentStatus;
  String? deliveryStatus;
  String? shippingType;
  String? pickupPointId;
  String? productReferralCode;
  String? createdAt;
  String? updatedAt;
  String? service_fee;

  OrderDetail(
      {this.id,
      this.orderId,
      this.sellerId,
      this.productId,
      this.productName,
      this.thumbnailImg,
      this.variation,
      this.price,
      this.tax,
      this.shippingCost,
      this.quantity,
      this.paymentStatus,
      this.deliveryStatus,
      this.shippingType,
      this.pickupPointId,
      this.productReferralCode,
      this.createdAt,
        this.service_fee,
      this.updatedAt});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    service_fee=json['service_fee'].toString();
    sellerId = json['seller_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    thumbnailImg = json['thumbnail_img'];
    variation = json['variation'];
    price = json['price'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    quantity = json['quantity'];
    paymentStatus = json['payment_status'];
    deliveryStatus = json['delivery_status'];
    shippingType = json['shipping_type'];
    pickupPointId = json['pickup_point_id'];
    productReferralCode = json['product_referral_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['seller_id'] = this.sellerId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['thumbnail_img'] = this.thumbnailImg;
    data['variation'] = this.variation;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['shipping_cost'] = this.shippingCost;
    data['quantity'] = this.quantity;
    data['payment_status'] = this.paymentStatus;
    data['delivery_status'] = this.deliveryStatus;
    data['shipping_type'] = this.shippingType;
    data['pickup_point_id'] = this.pickupPointId;
    data['product_referral_code'] = this.productReferralCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
