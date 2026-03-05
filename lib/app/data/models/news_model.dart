//Article data model
// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    Articles articles;

    NewsModel({
        required this.articles,
    });

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        articles: Articles.fromJson(json["articles"]),
    );

    Map<String, dynamic> toJson() => {
        "articles": articles.toJson(),
    };
}

class Articles {
    List<Result> results;
    int totalResults;
    int page;
    int count;
    int pages;

    Articles({
        required this.results,
        required this.totalResults,
        required this.page,
        required this.count,
        required this.pages,
    });

    factory Articles.fromJson(Map<String, dynamic> json) => Articles(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalResults: json["totalResults"],
        page: json["page"],
        count: json["count"],
        pages: json["pages"],
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "totalResults": totalResults,
        "page": page,
        "count": count,
        "pages": pages,
    };
}

class Result {
    String uri;
    Lang lang;
    bool isDuplicate;
    DateTime date;
    String time;
    DateTime dateTime;
    DateTime dateTimePub;
    DataType dataType;
    double sim;
    String url;
    String title;
    String body;
    Source source;
    List<Author> authors;
    String? image;
    String? eventUri;
    double sentiment;
    int wgt;
    int relevance;

    Result({
        required this.uri,
        required this.lang,
        required this.isDuplicate,
        required this.date,
        required this.time,
        required this.dateTime,
        required this.dateTimePub,
        required this.dataType,
        required this.sim,
        required this.url,
        required this.title,
        required this.body,
        required this.source,
        required this.authors,
        required this.image,
        required this.eventUri,
        required this.sentiment,
        required this.wgt,
        required this.relevance,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        uri: json["uri"],
        lang: langValues.map[json["lang"]]!,
        isDuplicate: json["isDuplicate"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        dateTime: DateTime.parse(json["dateTime"]),
        dateTimePub: DateTime.parse(json["dateTimePub"]),
        dataType: dataTypeValues.map[json["dataType"]]!,
        sim: json["sim"]?.toDouble(),
        url: json["url"],
        title: json["title"],
        body: json["body"],
        source: Source.fromJson(json["source"]),
        authors: List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
        image: json["image"],
        eventUri: json["eventUri"],
        sentiment: json["sentiment"]?.toDouble(),
        wgt: json["wgt"],
        relevance: json["relevance"],
    );

    Map<String, dynamic> toJson() => {
        "uri": uri,
        "lang": langValues.reverse[lang],
        "isDuplicate": isDuplicate,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "dateTime": dateTime.toIso8601String(),
        "dateTimePub": dateTimePub.toIso8601String(),
        "dataType": dataTypeValues.reverse[dataType],
        "sim": sim,
        "url": url,
        "title": title,
        "body": body,
        "source": source.toJson(),
        "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
        "image": image,
        "eventUri": eventUri,
        "sentiment": sentiment,
        "wgt": wgt,
        "relevance": relevance,
    };
}

class Author {
    String uri;
    String name;
    String type;
    bool isAgency;

    Author({
        required this.uri,
        required this.name,
        required this.type,
        required this.isAgency,
    });

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        uri: json["uri"],
        name: json["name"],
        type: json["type"],
        isAgency: json["isAgency"],
    );

    Map<String, dynamic> toJson() => {
        "uri": uri,
        "name": name,
        "type": type,
        "isAgency": isAgency,
    };
}

enum DataType {
    news
}

final dataTypeValues = EnumValues({
    "news": DataType.news
});

enum Lang {
    eng
}

final langValues = EnumValues({
    "eng": Lang.eng
});

class Source {
    String uri;
    DataType dataType;
    String title;

    Source({
        required this.uri,
        required this.dataType,
        required this.title,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        uri: json["uri"],
        dataType: dataTypeValues.map[json["dataType"]]!,
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "uri": uri,
        "dataType": dataTypeValues.reverse[dataType],
        "title": title,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
