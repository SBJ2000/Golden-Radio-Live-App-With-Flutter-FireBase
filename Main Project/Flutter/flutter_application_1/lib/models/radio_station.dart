// La classe RadioStation représente une station de radio.
class RadioStation {
  // Le nom de la station.
  final String name;
  // L'URL de diffusion en continu de la station.
  final String streamUrl;
  // L'URL de la photo de la station.
  final String photoUrl;
  // Le favori de la station.
  bool fav;

  // Le constructeur de la classe RadioStation.
  RadioStation({
    required this.name,
    required this.streamUrl,
    required this.photoUrl,
    required this.fav,
  });

  // Le constructeur de fabrique pour créer une instance de RadioStation à partir d'un JSON.
  factory RadioStation.fromJson(Map<String, dynamic> json) {
    return RadioStation(
      name: json['name'],
      streamUrl: json['streamUrl'],
      photoUrl: json['photoUrl'],
      fav: json['fav'],
    );
  }

  // Convertit l'objet RadioStation en un map JSON.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'streamUrl': streamUrl,
      'photoUrl': photoUrl,
      'fav': fav,
    };
  }

  // Retourne une instance de RadioStation vide.
  static RadioStation empty() {
    return RadioStation(name: '', streamUrl: '', photoUrl: '', fav: false);
  }

  // Le constructeur de fabrique pour créer une instance de RadioStation à partir d'un map.
  factory RadioStation.fromMap(Map<String, dynamic> map) {
    return RadioStation(
      name: map['name'],
      photoUrl: map['photoUrl'],
      streamUrl: map['streamUrl'],
      fav: map['fav'] ?? false,
    );
  }
}
