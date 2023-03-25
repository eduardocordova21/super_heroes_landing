import 'data.dart';

class Character {
  String? code;
  String? status;
  String? copyright;
  String? attributionText;
  String? attributionHTML;
  Data? data;
  String? etag;

  Character(
      {this.code,
      this.status,
      this.copyright,
      this.attributionText,
      this.attributionHTML,
      this.data,
      this.etag});

  Character.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    copyright = json['copyright'];
    attributionText = json['attributionText'];
    attributionHTML = json['attributionHTML'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    etag = json['etag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['copyright'] = copyright;
    data['attributionText'] = attributionText;
    data['attributionHTML'] = attributionHTML;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['etag'] = etag;
    return data;
  }
}
