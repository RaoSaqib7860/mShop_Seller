class DownloadModel {
  bool? result;
  String? documentUrl;

  DownloadModel({this.result, this.documentUrl});

  DownloadModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    documentUrl = json['document_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['document_url'] = this.documentUrl;
    return data;
  }
}
