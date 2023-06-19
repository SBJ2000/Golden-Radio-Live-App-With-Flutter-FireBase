// Importation des bibliothèques nécessaires
import 'package:flutter/foundation.dart';
import '../models/radio_station.dart';

// Définition de la classe RadioProvider qui étend la classe ChangeNotifier pour permettre la mise à jour de l'interface utilisateur en cas de modification de données
class RadioProvider with ChangeNotifier {
  final RadioStation initialRadioStation; // RadioStation initiale

// Constructeur de la classe RadioProvider qui prend en paramètre la RadioStation initiale
  RadioProvider(this.initialRadioStation);

  RadioStation? _station; // RadioStation courante

// Getter pour récupérer la RadioStation courante. Si la RadioStation courante n'est pas définie, on renvoie la RadioStation initiale
  RadioStation get station => _station ?? initialRadioStation;

// Getter pour récupérer la RadioStation courante
  RadioStation? get radioStation => _station;

// Setter pour définir la RadioStation courante. Cette méthode met à jour la RadioStation courante et notifie les auditeurs (les widgets qui écoutent les changements de données) que les données ont été modifiées
  void setRadioStation(RadioStation station) {
    _station = station;
    notifyListeners();
  }
}