import 'package:super_heroes_landing/models/results.dart';

class ResponseData {
  late int offset;
  late int limit;
  late int total;
  late int count;
  late List<Results> results;

  ResponseData(this.offset, this.limit, this.total, this.count, this.results);

  ResponseData.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offset'] = offset;
    data['limit'] = limit;
    data['total'] = total;
    data['count'] = count;
    data['results'] = results!.map((v) => v.toJson()).toList();
    return data;
  }
}
