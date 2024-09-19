class AddCartCountModel {
  int? count;
  bool? status;

  AddCartCountModel({this.count, this.status});

  AddCartCountModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['status'] = this.status;
    return data;
  }
}
