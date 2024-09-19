class AddProductResponceModel {
  bool? success;
  int? status;
  String? productLink;
  int? productId;
  String? message;

  AddProductResponceModel(
      {this.success,
      this.status,
      this.productLink,
      this.productId,
      this.message});

  AddProductResponceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    productLink = json['product_link'];
    productId = json['product_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['product_link'] = this.productLink;
    data['product_id'] = this.productId;
    data['message'] = this.message;
    return data;
  }
}
