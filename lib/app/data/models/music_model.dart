// To parse this JSON data, do
//
//     final musicModel = musicModelFromJson(jsonString);

import 'dart:convert';

MusicModel musicModelFromJson(String str) => MusicModel.fromJson(json.decode(str));

String musicModelToJson(MusicModel data) => json.encode(data.toJson());

class MusicModel {
  int resultCount;
  List<Result> results;

  MusicModel({
    required this.resultCount,
    required this.results,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
    resultCount: json["resultCount"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "resultCount": resultCount,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  WrapperType wrapperType;
  String? kind;
  int? trackId;
  String artistName;
  String? trackName;
  String? trackCensoredName;
  String? trackViewUrl;
  String? previewUrl;
  String? artworkUrl30;
  String? artworkUrl60;
  String? artworkUrl100;
  double? collectionPrice;
  double? trackPrice;
  double? trackRentalPrice;
  double? collectionHdPrice;
  double? trackHdPrice;
  double? trackHdRentalPrice;
  DateTime releaseDate;
  Explicitness collectionExplicitness;
  Explicitness? trackExplicitness;
  int? trackTimeMillis;
  Country country;
  Currency currency;
  String primaryGenreName;
  String? contentAdvisoryRating;
  String? shortDescription;
  String? longDescription;
  int? artistId;
  int? collectionId;
  String? collectionName;
  String? collectionCensoredName;
  String? artistViewUrl;
  String? collectionViewUrl;
  int? discCount;
  int? discNumber;
  int? trackCount;
  int? trackNumber;
  int? collectionArtistId;
  String? collectionArtistViewUrl;
  String? description;
  String? copyright;
  int? amgArtistId;

  Result({
    required this.wrapperType,
    this.kind,
    this.trackId,
    required this.artistName,
    this.trackName,
    this.trackCensoredName,
    this.trackViewUrl,
    this.previewUrl,
    this.artworkUrl30,
    this.artworkUrl60,
    this.artworkUrl100,
    this.collectionPrice,
    this.trackPrice,
    this.trackRentalPrice,
    this.collectionHdPrice,
    this.trackHdPrice,
    this.trackHdRentalPrice,
    required this.releaseDate,
    required this.collectionExplicitness,
    this.trackExplicitness,
    this.trackTimeMillis,
    required this.country,
    required this.currency,
    required this.primaryGenreName,
    this.contentAdvisoryRating,
    this.shortDescription,
    this.longDescription,
    this.artistId,
    this.collectionId,
    this.collectionName,
    this.collectionCensoredName,
    this.artistViewUrl,
    this.collectionViewUrl,
    this.discCount,
    this.discNumber,
    this.trackCount,
    this.trackNumber,
    this.collectionArtistId,
    this.collectionArtistViewUrl,
    this.description,
    this.copyright,
    this.amgArtistId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    wrapperType: wrapperTypeValues.map[json["wrapperType"]]!,
    kind: json["kind"],
    trackId: json["trackId"],
    artistName: json["artistName"],
    trackName: json["trackName"],
    trackCensoredName: json["trackCensoredName"],
    trackViewUrl: json["trackViewUrl"],
    previewUrl: json["previewUrl"],
    artworkUrl30: json["artworkUrl30"],
    artworkUrl60: json["artworkUrl60"],
    artworkUrl100: json["artworkUrl100"],
    collectionPrice: json["collectionPrice"]?.toDouble(),
    trackPrice: json["trackPrice"]?.toDouble(),
    trackRentalPrice: json["trackRentalPrice"]?.toDouble(),
    collectionHdPrice: json["collectionHdPrice"]?.toDouble(),
    trackHdPrice: json["trackHdPrice"]?.toDouble(),
    trackHdRentalPrice: json["trackHdRentalPrice"]?.toDouble(),
    releaseDate: DateTime.parse(json["releaseDate"]),
    collectionExplicitness: explicitnessValues.map[json["collectionExplicitness"]] ?? Explicitness.NOT_EXPLICIT,
    trackExplicitness: explicitnessValues.map[json["trackExplicitness"]],
    trackTimeMillis: json["trackTimeMillis"],
    country: countryValues.map[json["country"]]!,
    currency: currencyValues.map[json["currency"]]!,
    primaryGenreName: json["primaryGenreName"],
    contentAdvisoryRating: json["contentAdvisoryRating"],
    shortDescription: json["shortDescription"],
    longDescription: json["longDescription"],
    artistId: json["artistId"],
    collectionId: json["collectionId"],
    collectionName: json["collectionName"],
    collectionCensoredName: json["collectionCensoredName"],
    artistViewUrl: json["artistViewUrl"],
    collectionViewUrl: json["collectionViewUrl"],
    discCount: json["discCount"],
    discNumber: json["discNumber"],
    trackCount: json["trackCount"],
    trackNumber: json["trackNumber"],
    collectionArtistId: json["collectionArtistId"],
    collectionArtistViewUrl: json["collectionArtistViewUrl"],
    description: json["description"],
    copyright: json["copyright"],
    amgArtistId: json["amgArtistId"],
  );

  Map<String, dynamic> toJson() => {
    "wrapperType": wrapperTypeValues.reverse[wrapperType],
    "kind": kind,
    "trackId": trackId,
    "artistName": artistName,
    "trackName": trackName,
    "trackCensoredName": trackCensoredName,
    "trackViewUrl": trackViewUrl,
    "previewUrl": previewUrl,
    "artworkUrl30": artworkUrl30,
    "artworkUrl60": artworkUrl60,
    "artworkUrl100": artworkUrl100,
    "collectionPrice": collectionPrice,
    "trackPrice": trackPrice,
    "trackRentalPrice": trackRentalPrice,
    "collectionHdPrice": collectionHdPrice,
    "trackHdPrice": trackHdPrice,
    "trackHdRentalPrice": trackHdRentalPrice,
    "releaseDate": releaseDate.toIso8601String(),
    "collectionExplicitness": explicitnessValues.reverse[collectionExplicitness],
    "trackExplicitness": explicitnessValues.reverse[trackExplicitness],
    "trackTimeMillis": trackTimeMillis,
    "country": countryValues.reverse[country],
    "currency": currencyValues.reverse[currency],
    "primaryGenreName": primaryGenreName,
    "contentAdvisoryRating": contentAdvisoryRating,
    "shortDescription": shortDescription,
    "longDescription": longDescription,
    "artistId": artistId,
    "collectionId": collectionId,
    "collectionName": collectionName,
    "collectionCensoredName": collectionCensoredName,
    "artistViewUrl": artistViewUrl,
    "collectionViewUrl": collectionViewUrl,
    "discCount": discCount,
    "discNumber": discNumber,
    "trackCount": trackCount,
    "trackNumber": trackNumber,
    "collectionArtistId": collectionArtistId,
    "collectionArtistViewUrl": collectionArtistViewUrl,
    "description": description,
    "copyright": copyright,
    "amgArtistId": amgArtistId,
  };
}

enum Explicitness {
  CLEANED,
  EXPLICIT,
  NOT_EXPLICIT
}

final explicitnessValues = EnumValues({
  "cleaned": Explicitness.CLEANED,
  "explicit": Explicitness.EXPLICIT,
  "notExplicit": Explicitness.NOT_EXPLICIT
});

enum Country {
  USA
}

final countryValues = EnumValues({
  "USA": Country.USA
});

enum Currency {
  USD
}

final currencyValues = EnumValues({
  "USD": Currency.USD
});

enum WrapperType {
  AUDIOBOOK,
  TRACK
}

final wrapperTypeValues = EnumValues({
  "audiobook": WrapperType.AUDIOBOOK,
  "track": WrapperType.TRACK
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
