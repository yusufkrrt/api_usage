// To parse this JSON data, do
//
//     final foodModel = foodModelFromJson(jsonString);

import 'dart:convert';

FoodModel foodModelFromJson(String str) => FoodModel.fromJson(json.decode(str));

String foodModelToJson(FoodModel data) => json.encode(data.toJson());

class FoodModel {
    List<Result> results;
    int offset;
    int number;
    int totalResults;

    FoodModel({
        required this.results,
        required this.offset,
        required this.number,
        required this.totalResults,
    });

    factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        offset: json["offset"],
        number: json["number"],
        totalResults: json["totalResults"],
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "offset": offset,
        "number": number,
        "totalResults": totalResults,
    };
}

class Result {
    int id;
    String image;
    ImageType imageType;
    String title;
    int readyInMinutes;
    int servings;
    String sourceUrl;
    bool vegetarian;
    bool vegan;
    bool glutenFree;
    bool dairyFree;
    bool veryHealthy;
    bool cheap;
    bool veryPopular;
    bool sustainable;
    bool lowFodmap;
    int weightWatcherSmartPoints;
    Gaps gaps;
    int? preparationMinutes;
    int? cookingMinutes;
    int aggregateLikes;
    int healthScore;
    CreditsText creditsText;
    String? license;
    SourceName sourceName;
    double pricePerServing;
    String summary;
    List<String> cuisines;
    List<DishType> dishTypes;
    List<String> diets;
    List<dynamic> occasions;
    Language language;
    double spoonacularScore;
    String spoonacularSourceUrl;

    Result({
        required this.id,
        required this.image,
        required this.imageType,
        required this.title,
        required this.readyInMinutes,
        required this.servings,
        required this.sourceUrl,
        required this.vegetarian,
        required this.vegan,
        required this.glutenFree,
        required this.dairyFree,
        required this.veryHealthy,
        required this.cheap,
        required this.veryPopular,
        required this.sustainable,
        required this.lowFodmap,
        required this.weightWatcherSmartPoints,
        required this.gaps,
        required this.preparationMinutes,
        required this.cookingMinutes,
        required this.aggregateLikes,
        required this.healthScore,
        required this.creditsText,
        required this.license,
        required this.sourceName,
        required this.pricePerServing,
        required this.summary,
        required this.cuisines,
        required this.dishTypes,
        required this.diets,
        required this.occasions,
        required this.language,
        required this.spoonacularScore,
        required this.spoonacularSourceUrl,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        image: json["image"],
        imageType: imageTypeValues.map[json["imageType"]]!,
        title: json["title"],
        readyInMinutes: json["readyInMinutes"],
        servings: json["servings"],
        sourceUrl: json["sourceUrl"],
        vegetarian: json["vegetarian"],
        vegan: json["vegan"],
        glutenFree: json["glutenFree"],
        dairyFree: json["dairyFree"],
        veryHealthy: json["veryHealthy"],
        cheap: json["cheap"],
        veryPopular: json["veryPopular"],
        sustainable: json["sustainable"],
        lowFodmap: json["lowFodmap"],
        weightWatcherSmartPoints: json["weightWatcherSmartPoints"],
        gaps: gapsValues.map[json["gaps"]]!,
        preparationMinutes: json["preparationMinutes"],
        cookingMinutes: json["cookingMinutes"],
        aggregateLikes: json["aggregateLikes"],
        healthScore: json["healthScore"],
        creditsText: creditsTextValues.map[json["creditsText"]]!,
        license: json["license"],
        sourceName: sourceNameValues.map[json["sourceName"]]!,
        pricePerServing: json["pricePerServing"]?.toDouble(),
        summary: json["summary"],
        cuisines: List<String>.from(json["cuisines"].map((x) => x)),
        dishTypes: List<DishType>.from(json["dishTypes"].map((x) => dishTypeValues.map[x]!)),
        diets: List<String>.from(json["diets"].map((x) => x)),
        occasions: List<dynamic>.from(json["occasions"].map((x) => x)),
        language: languageValues.map[json["language"]]!,
        spoonacularScore: json["spoonacularScore"]?.toDouble(),
        spoonacularSourceUrl: json["spoonacularSourceUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "imageType": imageTypeValues.reverse[imageType],
        "title": title,
        "readyInMinutes": readyInMinutes,
        "servings": servings,
        "sourceUrl": sourceUrl,
        "vegetarian": vegetarian,
        "vegan": vegan,
        "glutenFree": glutenFree,
        "dairyFree": dairyFree,
        "veryHealthy": veryHealthy,
        "cheap": cheap,
        "veryPopular": veryPopular,
        "sustainable": sustainable,
        "lowFodmap": lowFodmap,
        "weightWatcherSmartPoints": weightWatcherSmartPoints,
        "gaps": gapsValues.reverse[gaps],
        "preparationMinutes": preparationMinutes,
        "cookingMinutes": cookingMinutes,
        "aggregateLikes": aggregateLikes,
        "healthScore": healthScore,
        "creditsText": creditsTextValues.reverse[creditsText],
        "license": license,
        "sourceName": sourceNameValues.reverse[sourceName],
        "pricePerServing": pricePerServing,
        "summary": summary,
        "cuisines": List<dynamic>.from(cuisines.map((x) => x)),
        "dishTypes": List<dynamic>.from(dishTypes.map((x) => dishTypeValues.reverse[x])),
        "diets": List<dynamic>.from(diets.map((x) => x)),
        "occasions": List<dynamic>.from(occasions.map((x) => x)),
        "language": languageValues.reverse[language],
        "spoonacularScore": spoonacularScore,
        "spoonacularSourceUrl": spoonacularSourceUrl,
    };
}

enum CreditsText {
    FOODISTA_COM,
    FOODISTA_COM_THE_COOKING_ENCYCLOPEDIA_EVERYONE_CAN_EDIT,
    FULL_BELLY_SISTERS
}

final creditsTextValues = EnumValues({
    "foodista.com": CreditsText.FOODISTA_COM,
    "Foodista.com – The Cooking Encyclopedia Everyone Can Edit": CreditsText.FOODISTA_COM_THE_COOKING_ENCYCLOPEDIA_EVERYONE_CAN_EDIT,
    "Full Belly Sisters": CreditsText.FULL_BELLY_SISTERS
});

enum DishType {
    DINNER,
    LUNCH,
    MAIN_COURSE,
    MAIN_DISH,
    SIDE_DISH
}

final dishTypeValues = EnumValues({
    "dinner": DishType.DINNER,
    "lunch": DishType.LUNCH,
    "main course": DishType.MAIN_COURSE,
    "main dish": DishType.MAIN_DISH,
    "side dish": DishType.SIDE_DISH
});

enum Gaps {
    NO
}

final gapsValues = EnumValues({
    "no": Gaps.NO
});

enum ImageType {
    JPG
}

final imageTypeValues = EnumValues({
    "jpg": ImageType.JPG
});

enum Language {
    EN
}

final languageValues = EnumValues({
    "en": Language.EN
});

enum SourceName {
    FOODISTA,
    FOODISTA_COM,
    FULL_BELLY_SISTERS
}

final sourceNameValues = EnumValues({
    "Foodista": SourceName.FOODISTA,
    "foodista.com": SourceName.FOODISTA_COM,
    "Full Belly Sisters": SourceName.FULL_BELLY_SISTERS
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
