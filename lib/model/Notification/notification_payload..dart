class NotificationPayload {
  Aps? aps;
  Custom? custom;

  NotificationPayload({this.aps, this.custom});

  NotificationPayload.fromJson(Map<String, dynamic> json) {
    aps = json['aps'] != null ? new Aps.fromJson(json['aps']) : null;
    custom =
        json['custom'] != null ? new Custom.fromJson(json['custom']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aps != null) {
      data['aps'] = this.aps!.toJson();
    }
    if (this.custom != null) {
      data['custom'] = this.custom!.toJson();
    }
    return data;
  }
}

class Aps {
  Alert? alert;
  int? mutableContent;
  String? sound;

  Aps({this.alert, this.mutableContent, this.sound});

  Aps.fromJson(Map<String, dynamic> json) {
    alert = json['alert'] != null ? new Alert.fromJson(json['alert']) : null;
    mutableContent = json['mutable-content'];
    sound = json['sound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alert != null) {
      data['alert'] = this.alert!.toJson();
    }
    data['mutable-content'] = this.mutableContent;
    data['sound'] = this.sound;
    return data;
  }
}

class Alert {
  String? title;
  String? body;

  Alert({this.title, this.body});

  Alert.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}

class Custom {
  A? a;
  String? i;
  String? collapseId;

  Custom({this.a, this.i, this.collapseId});

  Custom.fromJson(Map<String, dynamic> json) {
    a = json['a'] != null ? new A.fromJson(json['a']) : null;
    i = json['i'];
    collapseId = json['collapse_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.a != null) {
      data['a'] = this.a!.toJson();
    }
    data['i'] = this.i;
    data['collapse_id'] = this.collapseId;
    return data;
  }
}

class A {
  int? orderId;
  String? hash_code;
  String? action;
  A({this.orderId, this.hash_code, this.action});

  A.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    hash_code = json['hash_code'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['hash_code'] = this.hash_code;
    data['action'] = this.action;
    return data;
  }
}
