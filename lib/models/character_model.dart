class CharacterModel {
  final String id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final DateTime created;

  CharacterModel({required this.id, required this.name, required this.status, required this.species, required this.type, required this.gender, required this.image, required this.created});

  CharacterModel copyWith({String? id, String? name, String? status, String? species, String? type, String? gender, String? image, DateTime? created}) => CharacterModel(
    id: id ?? this.id,
    name: name ?? this.name,
    status: status ?? this.status,
    species: species ?? this.species,
    type: type ?? this.type,
    gender: gender ?? this.gender,
    image: image ?? this.image,
    created: created ?? this.created,
  );

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    try {
      return CharacterModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        status: json['status'] ?? '',
        species: json['species'] ?? '',
        type: json['type'] ?? '',
        gender: json['gender'] ?? '',
        image: json['image'] ?? '',
        created: DateTime.tryParse(json['created']) ?? DateTime.now(),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "status": status, "species": species, "type": type, "gender": gender, "image": image, "created": created};
  }
}
