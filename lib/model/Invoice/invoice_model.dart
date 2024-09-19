class invoiceModelView {
  bool? result;
  List<Data>? data;
  Links? links;
  Meta? meta;

  invoiceModelView({this.result, this.data, this.links, this.meta});

  invoiceModelView.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? orderNumber;
  String? invoiceNumber;
  String? invoice;
  List<CombineOrders>? combineOrders;
  String? orderDate;
  String? deliveryStatus;
  String? paymentMethod;
  String? paymentStatus;

  Data(
      {this.id,
        this.orderNumber,
        this.invoiceNumber,
        this.invoice,
        this.combineOrders,
        this.orderDate,
        this.deliveryStatus,
        this.paymentMethod,
        this.paymentStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    invoiceNumber = json['invoice_number'];
    invoice = json['invoice'];
    if (json['combine_orders'] != null) {
      combineOrders = <CombineOrders>[];
      json['combine_orders'].forEach((v) {
        combineOrders!.add(new CombineOrders.fromJson(v));
      });
    }
    orderDate = json['order_date'];
    deliveryStatus = json['delivery_status'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_number'] = this.orderNumber;
    data['invoice_number'] = this.invoiceNumber;
    data['invoice'] = this.invoice;
    if (this.combineOrders != null) {
      data['combine_orders'] =
          this.combineOrders!.map((v) => v.toJson()).toList();
    }
    data['order_date'] = this.orderDate;
    data['delivery_status'] = this.deliveryStatus;
    data['payment_method'] = this.paymentMethod;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}

class CombineOrders {
  int? productId;
  String? productTitle;
  String? productSlug;
  String? link;
  String? thumbnail;

  CombineOrders(
      {this.productId,
        this.productTitle,
        this.productSlug,
        this.link,
        this.thumbnail});

  CombineOrders.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productTitle = json['product_title'];
    productSlug = json['product_slug'];
    link = json['link'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_title'] = this.productTitle;
    data['product_slug'] = this.productSlug;
    data['link'] = this.link;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  dynamic? prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
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
  List<LinksView>? links;
  String? path;
  String? perPage;
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
      links = <LinksView>[];
      json['links'].forEach((v) {
        links!.add(new LinksView.fromJson(v));
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

class LinksView {
  String? url;
  String? label;
  bool? active;

  LinksView({this.url, this.label, this.active});

  LinksView.fromJson(Map<String, dynamic> json) {
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
