import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/shared_prefs_api.dart';
import 'package:flutter_application_1/models/radio_station.dart';
import 'package:flutter_application_1/providers/radio_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../apis/radio_api.dart';

class RadioList extends StatefulWidget {
  const RadioList({super.key});

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  // Déclare les variables nécessaires
  late RadioStation selectedStation;
  late RadioProvider provider;
  List<RadioStation> stations = [];


  @override
  void initState() {
    super.initState();
    // Initialise provider et selectedStation
    provider = Provider.of<RadioProvider>(context, listen: false);
    selectedStation = provider.station;
    // Appelle la fonction _loadStations lors de l'initialisation
    _loadStations();

  }
  Future<void> _loadStations() async {
    final api = RadioApi();
    // Récupère la liste de toutes les stations de radio en utilisant l'API RadioApi
    final List<RadioStation> allStations = await api.getAllStations();
    setState(() {
      stations = allStations;
    });
  }


  @override
  Widget build(BuildContext context) {
    // Récupère la liste des stations de radio à partir de Provider
    final provider = Provider.of<RadioProvider>(context, listen: false);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];
          bool isSelected = station == selectedStation;
          return Container(
            color: isSelected ? const Color(0xFFF2E5DC) : null,
            child: ListTile(
              leading: SizedBox(
                width: 55,
                child: Image.network(
                  station.photoUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              horizontalTitleGap: 50,
              title: Text(
                station.name,
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  size: 40,
                  station.fav ? Icons.favorite : Icons.favorite_border,
                  color: station.fav ? Colors.red : null,
                ),
                onPressed: () async {
                  final currentUser = FirebaseAuth.instance.currentUser;
                  if (currentUser == null) {
                  // Si l'utilisateur n'est pas connecté, affiche un message d'erreur ou redirige vers la page de connexion
                    return;
                  }
                  final favoritesCollection = FirebaseFirestore.instance.collection('favorites_radios');
                  final selectedStationMap = {
                    'userid': currentUser.uid,
                    'name': station.name,
                    'photoUrl': station.photoUrl,
                    'streamUrl': station.streamUrl,
                    'fav': !station.fav,
                  };
                  final radioStationQuerySnapshot = await FirebaseFirestore.instance
                      .collection('radio_stations')
                      .where('name', isEqualTo: station.name)
                      .get();
                  if (radioStationQuerySnapshot.docs.isNotEmpty) {
                    final radioStationId = radioStationQuerySnapshot.docs.first.id;
                    await FirebaseFirestore.instance
                        .collection('radio_stations')
                        .doc(radioStationId)
                        .update({'fav': !station.fav});
                  }
                  final querySnapshot = await favoritesCollection
                      .where('userid', isEqualTo: currentUser.uid)
                      .where('name', isEqualTo: station.name)
                      .get();
                  if (querySnapshot.docs.isEmpty) {
                    // No documents exist with the same user id and name, add the new document
                    await favoritesCollection.add(selectedStationMap);
                  } else {
                    // A document already exists with the same user id and name, remove it
                    final documentId = querySnapshot.docs.first.id;
                    await favoritesCollection.doc(documentId).delete();
                  }
                  // Update the favorite status of the station
                  setState(() {
                    station.fav = !station.fav;
                  });
                },
              ),
              onTap: () async {
                provider.setRadioStation(station);
                SharedPrefsApi.setStation(station);
                await RadioApi.changeStation(station);
                setState(() {
                  selectedStation = station;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
