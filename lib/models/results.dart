import 'package:super_heroes_landing/models/thumbnail.dart';
import 'package:super_heroes_landing/models/urls.dart';
import 'comics.dart';

class Results {
  late int id;
  late String name;
  late String description;
  late String modified;
  late String resourceURI;
  late List<Urls> urls;
  late Thumbnail thumbnail;
  late Comics comics;
  late Comics stories;
  late Comics events;
  late Comics series;

  Results(
      this.id,
      this.name,
      this.description,
      this.modified,
      this.resourceURI,
      this.urls,
      this.thumbnail,
      this.comics,
      this.stories,
      this.events,
      this.series);

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    modified = json['modified'];
    resourceURI = json['resourceURI'];
    if (json['urls'] != null) {
      urls = <Urls>[];
      json['urls'].forEach((v) {
        urls!.add(Urls.fromJson(v));
      });
    }
    thumbnail = Thumbnail.fromJson(json['thumbnail']);
    comics = Comics.fromJson(json['comics']);
    stories = Comics.fromJson(json['stories']);
    events = Comics.fromJson(json['events']);
    series = Comics.fromJson(json['series']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['modified'] = modified;
    data['resourceURI'] = resourceURI;
    data['urls'] = urls!.map((v) => v.toJson()).toList();
    data['thumbnail'] = thumbnail!.toJson();
    data['comics'] = comics!.toJson();
    data['stories'] = stories!.toJson();
    data['events'] = events!.toJson();
    data['series'] = series!.toJson();
    return data;
  }
}
