import 'package:super_heroes_landing/models/character/thumbnail.dart';
import 'package:super_heroes_landing/models/character/urls.dart';

import 'comics.dart';

class Results {
  String? id;
  String? name;
  String? description;
  String? modified;
  String? resourceURI;
  List<Urls>? urls;
  Thumbnail? thumbnail;
  Comics? comics;
  Comics? stories;
  Comics? events;
  Comics? series;

  Results(
      {this.id,
      this.name,
      this.description,
      this.modified,
      this.resourceURI,
      this.urls,
      this.thumbnail,
      this.comics,
      this.stories,
      this.events,
      this.series});

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
    thumbnail = json['thumbnail'] != null
        ? Thumbnail.fromJson(json['thumbnail'])
        : null;
    comics = json['comics'] != null ? Comics.fromJson(json['comics']) : null;
    stories = json['stories'] != null ? Comics.fromJson(json['stories']) : null;
    events = json['events'] != null ? Comics.fromJson(json['events']) : null;
    series = json['series'] != null ? Comics.fromJson(json['series']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['modified'] = modified;
    data['resourceURI'] = resourceURI;
    if (urls != null) {
      data['urls'] = urls!.map((v) => v.toJson()).toList();
    }
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail!.toJson();
    }
    if (comics != null) {
      data['comics'] = comics!.toJson();
    }
    if (stories != null) {
      data['stories'] = stories!.toJson();
    }
    if (events != null) {
      data['events'] = events!.toJson();
    }
    if (series != null) {
      data['series'] = series!.toJson();
    }
    return data;
  }
}
