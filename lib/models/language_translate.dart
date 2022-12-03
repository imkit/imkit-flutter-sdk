class LanguageTranslate {
  Data? data;

  LanguageTranslate({this.data});

  LanguageTranslate.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Translations>? translations;

  Data({this.translations});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (translations != null) {
      data['translations'] = translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  String? translatedText;
  String? detectedSourceLanguage;

  Translations({this.translatedText, this.detectedSourceLanguage});

  Translations.fromJson(Map<String, dynamic> json) {
    translatedText = json['translatedText'];
    detectedSourceLanguage = json['detectedSourceLanguage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['translatedText'] = translatedText;
    data['detectedSourceLanguage'] = detectedSourceLanguage;
    return data;
  }
}
