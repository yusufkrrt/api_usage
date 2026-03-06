// To parse this JSON data, do
//
//     final coinModel = coinModelFromJson(jsonString);

import 'dart:convert';

CryptoModel cryptoModelFromJson(String str) => CryptoModel.fromJson(json.decode(str));

String cryptoModelToJson(CryptoModel data) => json.encode(data.toJson());

class CryptoModel {
  Status status;
  List<Datum> data;

  CryptoModel({
    required this.status,
    required this.data,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) => CryptoModel(
    status: Status.fromJson(json["status"]),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String name;
  String symbol;
  String slug;
  int cmcRank;
  int numMarketPairs;
  int circulatingSupply;
  int totalSupply;
  int maxSupply;
  dynamic infiniteSupply;
  DateTime lastUpdated;
  DateTime dateAdded;
  List<String> tags;
  dynamic platform;
  dynamic selfReportedCirculatingSupply;
  dynamic selfReportedMarketCap;
  double mintedMarketCap;
  Map<String, Quote> quote;

  Datum({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.cmcRank,
    required this.numMarketPairs,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.infiniteSupply,
    required this.lastUpdated,
    required this.dateAdded,
    required this.tags,
    required this.platform,
    required this.selfReportedCirculatingSupply,
    required this.selfReportedMarketCap,
    required this.mintedMarketCap,
    required this.quote,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    symbol: json["symbol"],
    slug: json["slug"],
    cmcRank: json["cmc_rank"],
    numMarketPairs: json["num_market_pairs"],
    circulatingSupply: json["circulating_supply"],
    totalSupply: json["total_supply"],
    maxSupply: json["max_supply"],
    infiniteSupply: json["infinite_supply"],
    lastUpdated: DateTime.parse(json["last_updated"]),
    dateAdded: DateTime.parse(json["date_added"]),
    tags: List<String>.from(json["tags"].map((x) => x)),
    platform: json["platform"],
    selfReportedCirculatingSupply: json["self_reported_circulating_supply"],
    selfReportedMarketCap: json["self_reported_market_cap"],
    mintedMarketCap: json["minted_market_cap"]?.toDouble(),
    quote: Map.from(json["quote"]).map((k, v) => MapEntry<String, Quote>(k, Quote.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "symbol": symbol,
    "slug": slug,
    "cmc_rank": cmcRank,
    "num_market_pairs": numMarketPairs,
    "circulating_supply": circulatingSupply,
    "total_supply": totalSupply,
    "max_supply": maxSupply,
    "infinite_supply": infiniteSupply,
    "last_updated": lastUpdated.toIso8601String(),
    "date_added": dateAdded.toIso8601String(),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "platform": platform,
    "self_reported_circulating_supply": selfReportedCirculatingSupply,
    "self_reported_market_cap": selfReportedMarketCap,
    "minted_market_cap": mintedMarketCap,
    "quote": Map.from(quote).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Quote {
  double price;
  int volume24H;
  double? volumeChange24H;
  double? percentChange1H;
  double? percentChange24H;
  double? percentChange7D;
  double marketCap;
  int marketCapDominance;
  double fullyDilutedMarketCap;
  DateTime lastUpdated;

  Quote({
    required this.price,
    required this.volume24H,
    required this.volumeChange24H,
    required this.percentChange1H,
    required this.percentChange24H,
    required this.percentChange7D,
    required this.marketCap,
    required this.marketCapDominance,
    required this.fullyDilutedMarketCap,
    required this.lastUpdated,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    price: json["price"]?.toDouble(),
    volume24H: json["volume_24h"],
    volumeChange24H: json["volume_change_24h"]?.toDouble(),
    percentChange1H: json["percent_change_1h"]?.toDouble(),
    percentChange24H: json["percent_change_24h"]?.toDouble(),
    percentChange7D: json["percent_change_7d"]?.toDouble(),
    marketCap: json["market_cap"]?.toDouble(),
    marketCapDominance: json["market_cap_dominance"],
    fullyDilutedMarketCap: json["fully_diluted_market_cap"]?.toDouble(),
    lastUpdated: DateTime.parse(json["last_updated"]),
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "volume_24h": volume24H,
    "volume_change_24h": volumeChange24H,
    "percent_change_1h": percentChange1H,
    "percent_change_24h": percentChange24H,
    "percent_change_7d": percentChange7D,
    "market_cap": marketCap,
    "market_cap_dominance": marketCapDominance,
    "fully_diluted_market_cap": fullyDilutedMarketCap,
    "last_updated": lastUpdated.toIso8601String(),
  };
}

class Status {
  DateTime timestamp;
  int errorCode;
  dynamic errorMessage;
  int elapsed;
  int creditCount;
  dynamic notice;

  Status({
    required this.timestamp,
    required this.errorCode,
    required this.errorMessage,
    required this.elapsed,
    required this.creditCount,
    required this.notice,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    timestamp: DateTime.parse(json["timestamp"]),
    errorCode: json["error_code"],
    errorMessage: json["error_message"],
    elapsed: json["elapsed"],
    creditCount: json["credit_count"],
    notice: json["notice"],
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp.toIso8601String(),
    "error_code": errorCode,
    "error_message": errorMessage,
    "elapsed": elapsed,
    "credit_count": creditCount,
    "notice": notice,
  };
}
