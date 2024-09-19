class LoginModel {
  bool? result;
  String? message;
  String? accessToken;
  String? tokenType;
  Null? expiresAt;
  User? user;

  LoginModel(
      {this.result,
      this.message,
      this.accessToken,
      this.tokenType,
      this.expiresAt,
      this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_at'] = this.expiresAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? type;
  String? name;
  String? email;
  bool? emailVerified;
  bool? phoneVerified;
  int? shopId;
  String? shopName;
  int? shopVerficationSubmitted;
  dynamic contractVerified;
  dynamic contractLink;
  int? shopVerfied;
  String? avatar;
  String? avatarOriginal;
  String? phone;

  User(
      {this.id,
      this.type,
      this.name,
      this.email,
      this.emailVerified,
      this.phoneVerified,
      this.shopId,
      this.shopName,
      this.shopVerficationSubmitted,
      this.contractVerified,
      this.contractLink,
      this.shopVerfied,
      this.avatar,
      this.avatarOriginal,
      this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    email = json['email'];
    emailVerified = json['email_verified'];
    phoneVerified = json['phone_verified'];
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    shopVerficationSubmitted = json['shop_verfication_submitted'];
    contractVerified = json['contract_verified'];
    contractLink = json['contract_link'];
    shopVerfied = int.parse('${json['shop_verfied']}');
    avatar = json['avatar'];
    avatarOriginal = json['avatar_original'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified'] = this.emailVerified;
    data['phone_verified'] = this.phoneVerified;
    data['shop_id'] = this.shopId;
    data['shop_name'] = this.shopName;
    data['shop_verfication_submitted'] = this.shopVerficationSubmitted;
    data['contract_verified'] = this.contractVerified;
    data['contract_link'] = this.contractLink;
    data['shop_verfied'] = this.shopVerfied;
    data['avatar'] = this.avatar;
    data['avatar_original'] = this.avatarOriginal;
    data['phone'] = this.phone;
    return data;
  }
}
