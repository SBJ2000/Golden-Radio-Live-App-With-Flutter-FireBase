import 'package:shared_preferences/shared_preferences.dart';
import '../models/radio_station.dart';
import '../utils/radio_station.dart';

class SharedPrefsApi {
  static const _key = 'radio_station';

  // Récupère la radio station initiale enregistrée dans les shared preferences
  static Future<RadioStation> getInitialRadioStation() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final stationName = sharedPrefs.getString(_key);

    // Si aucune station n'est enregistrée, retourne la première station de la liste de toutes les stations
    if (stationName == null) {
      return RadioStations.allStations[0];
    }

    // Retourne la station de radio qui correspond au nom de la station enregistré dans les shared preferences
    return RadioStations.allStations.firstWhere(
            (element) => element.name == stationName);
  }

  // Enregistre la station de radio dans les shared preferences
  static Future<void> setStation(RadioStation station) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(_key, station.name);
  }
}
