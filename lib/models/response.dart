import 'response_data.dart';

class Response {
  late int code;
  late String status;
  late String copyright;
  late String attributionText;
  late String attributionHTML;
  late ResponseData requestdata;
  late String etag;

  Response(this.code, this.status, this.copyright, this.attributionText,
      this.attributionHTML, this.requestdata, this.etag);

  Response.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    copyright = json['copyright'];
    attributionText = json['attributionText'];
    attributionHTML = json['attributionHTML'];
    requestdata = json['data'] = ResponseData.fromJson(json['data']);
    etag = json['etag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['copyright'] = copyright;
    data['attributionText'] = attributionText;
    data['attributionHTML'] = attributionHTML;
    data['data'] = requestdata!.toJson();
    data['etag'] = etag;
    return data;
  }
}
