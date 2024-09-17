class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String? type;
  final Origin origin;
  final Location location;
  final String image;
  final List<String> episodes;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    this.type,
    required this.origin,
    required this.location,
    required this.image,
    required this.episodes,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      species: json["species"],
      type: json["type"],
      origin: Origin.fromJson(json["origin"]),
      location: Location.fromJson(json["location"]),
      image: json["image"],
      episodes: List<String>.from(json["episode"]),
    );
  }
}

class Origin {
  final String name;

  Origin({required this.name});

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(
      name: json["name"],
    );
  }
}

class Location {
  final String name;

  Location({required this.name});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json["name"],
    );
  }
}
