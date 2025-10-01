class CountryModel {
  final String code;
  final String name;
  final String native;
  final ContinentModel continent;
  final String currency;
  final String emoji;
  final String emojiU;
  final String phone;
  final List<LanguageModel> languages;
  final List<StateModel> states;

  CountryModel({
    required this.code,
    required this.name,
    required this.native,
    required this.continent,
    required this.currency,
    required this.emoji,
    required this.emojiU,
    required this.phone,
    required this.languages,
    required this.states,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    try {
      return CountryModel(
        code: json['code'] ?? '',
        name: json['name'] ?? '',
        native: json['native'] ?? '',
        continent: json['continent'] != null
            ? ContinentModel.fromJson(json['continent'] as Map<String, dynamic>)
            : ContinentModel(code: '', name: ''),
        currency: json['currency'] ?? '',
        emoji: json['emoji'] ?? '',
        emojiU: json['emojiU'] ?? '',
        phone: json['phone'] ?? '',
        languages: (json['languages'] as List<dynamic>?)
            ?.map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
            [],
        states: (json['states'] as List<dynamic>?)
            ?.map((e) => StateModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
            [],
      );
    } catch (e) {
      // throw detailed error for debugging
      throw Exception("CountryModel parsing error: $e\nJSON: $json");
    }
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "native": native,
    "continent": continent.toJson(),
    "currency": currency,
    "emoji": emoji,
    "emojiU": emojiU,
    "phone": phone,
    "languages": languages.map((e) => e.toJson()).toList(),
    "states": states.map((e) => e.toJson()).toList(),
  };
}

class ContinentModel {
  final String code;
  final String name;

  ContinentModel({required this.code, required this.name});

  factory ContinentModel.fromJson(Map<String, dynamic> json) => ContinentModel(
    code: json['code'] ?? '',
    name: json['name'] ?? '',
  );

  Map<String, dynamic> toJson() => {"code": code, "name": name};
}

class LanguageModel {
  final String code;
  final String name;
  final String native;
  final int rtl;

  LanguageModel({
    required this.code,
    required this.name,
    required this.native,
    required this.rtl,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
    code: json['code'] ?? '',
    name: json['name'] ?? '',
    native: json['native'] ?? '',
    rtl: json['rtl'] is int
        ? json['rtl'] as int
        : int.tryParse(json['rtl']?.toString() ?? '0') ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "native": native,
    "rtl": rtl,
  };
}

class StateModel {
  final String code;
  final String name;
  final ContinentModel country;

  StateModel({
    required this.code,
    required this.name,
    required this.country,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    code: json['code'] ?? '',
    name: json['name'] ?? '',
    country: json['country'] != null
        ? ContinentModel.fromJson(json['country'] as Map<String, dynamic>)
        : ContinentModel(code: '', name: ''),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "country": country.toJson(),
  };
}
