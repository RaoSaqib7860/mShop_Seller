class WishlistCountModel {
  String? count;
  bool? status;

  WishlistCountModel({this.count, this.status});

  WishlistCountModel.fromJson(Map<String, dynamic> json) {
    count = json['count'].toString();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['status'] = this.status;
    return data;
  }
}