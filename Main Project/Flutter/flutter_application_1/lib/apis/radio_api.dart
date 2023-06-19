import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/models/radio_station.dart';
import 'package:provider/provider.dart';
import 'package:radio_player/radio_player.dart';
import '../providers/radio_provider.dart';

class RadioApi {
  static late RadioPlayer player;

// Cette fonction initialise le player en lui passant les informations de la radio choisie par l'utilisateur. Elle est appelée au démarrage de l'application.
  static Future<void> initPlayer(BuildContext context) async {
    final provider = Provider.of<RadioProvider>(context, listen: false);
    player = RadioPlayer();
    await player.stop();
    await player.setChannel(title: provider.station.name, url: provider.station.streamUrl);
    await player.play();
  }

// Cette fonction permet de changer de station de radio en arrêtant le player actuel, puis en initialisant un nouveau player avec les informations de la nouvelle radio.
  static Future<void> changeStation(RadioStation station) async {
    await player.stop();
    await player.setChannel(title: station.name, url: station.streamUrl);
    await player.play();
  }

// Cette variable permet de récupérer la référence à la collection de radios stockées dans la base de données Firestore.
  final CollectionReference _radioStationsCollection =
  FirebaseFirestore.instance.collection('radio_stations');

// Cette fonction récupère toutes les stations de radio stockées dans la base de données Firestore et les convertit en objets RadioStation.
  Future<List<RadioStation>> getAllStations() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
    await _radioStationsCollection.get() as QuerySnapshot<Map<String, dynamic>>;
    final List<RadioStation> stations = snapshot.docs
        .map((doc) => RadioStation.fromJson(doc.data()))
        .toList();
    return stations;
  }

// Cette fonction permet d'arrêter le player actuel.
  static void stop() {
    player.stop();
  }
}