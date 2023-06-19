import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/shared_prefs_api.dart';
import 'package:flutter_application_1/models/radio_station.dart';
import 'package:flutter_application_1/providers/radio_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../apis/radio_api.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key});

  @override
  State<FavoritesList> createState() => _RadioListState();
}

class _RadioListState extends State<FavoritesList> {
  // Initialisation de selectedStation et provider
  late RadioStation selectedStation;
  late RadioProvider provider;
  List<RadioStation> stations = [];


  @override
  void initState() {
    // Initialisation de la liste de stations
    super.initState();
    // On récupère le provider de RadioProvider pour obtenir la station sélectionnée
    provider = Provider.of<RadioProvider>(context, listen: false);
    // On initialise la station sélectionnée à la station courante du provider
    selectedStation = provider.station;
    // On charge toutes les stations
    _loadStations(); // Call the _loadStations function here

  }
  // Fonction pour charger toutes les stations à partir de l'API
  Future<void> _loadStations() async {
    final api = RadioApi();
    final List<RadioStation> allStations = await api.getAllStations();
    setState(() {
      stations = allStations;
    });
  }


  @override
  Widget build(BuildContext context) {
    // On récupère le provider de RadioProvider pour obtenir la station sélectionnée
    final provider = Provider.of<RadioProvider>(context, listen: false);
    // On filtre la liste de stations pour ne récupérer que les stations favorites
    final List<RadioStation> favoriteStations = stations.where((station) => station.fav).toList();
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        itemCount: favoriteStations.length,
        itemBuilder: (context, index) {
          final station = favoriteStations[index];
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
                  // Si l'utilisateur n'est pas connecté, on affiche un message d'erreur ou on le redirige vers la page de connexion
                  if (currentUser == null) {
                    // User is not logged in, show error message or redirect to login page
                    return;
                  }
                  // On récupère la collection de favoris
                  final favoritesCollection = FirebaseFirestore.instance.collection('favorites_radios');
                  // On crée un objet qui représente la station sélectionnée
                  final selectedStationMap = {
                    'userid': currentUser.uid,
                    'name': station.name,
                    'photoUrl': station.photoUrl,
                    'streamUrl': station.streamUrl,
                    'fav': !station.fav,
                  };
                  final radioStationQuerySnapshot = await FirebaseFirestore.instance
                      .collection('radio_stations')
                      .where('name', isEqualTo: station.name)// Recherche une station avec le même nom
                      .get();// Obtient un snapshot de la collection
                  if (radioStationQuerySnapshot.docs.isNotEmpty) {// Si un snapshot est trouvé
                    final radioStationId = radioStationQuerySnapshot.docs.first.id;// Obtient l'ID de la première station trouvée
                    await FirebaseFirestore.instance
                        .collection('radio_stations')
                        .doc(radioStationId)
                        .update({'fav': !station.fav});// Met à jour le statut de favori de la station dans la base de données
                  }
                  final querySnapshot = await favoritesCollection
                      .where('userid', isEqualTo: currentUser.uid) // Recherche des favoris de l'utilisateur actuel
                      .where('name', isEqualTo: station.name)// Recherche des favoris avec le même nom de station
                      .get();// Obtient un snapshot de la collection
                  if (querySnapshot.docs.isEmpty) {// Si aucun favori n'a été trouvé avec le même nom
                    // Ajoute le favori à la collection
                    await favoritesCollection.add(selectedStationMap);
                  } else {  // Supprime le favori existant avec le même nom
                    final documentId = querySnapshot.docs.first.id;// Obtient l'ID du premier favori trouvé
                    await favoritesCollection.doc(documentId).delete();
                  }
                  // Met à jour le statut de favori de la station localement
                  setState(() {
                    station.fav = !station.fav;
                  });
                },
              ),
              // Associe la fonction onTap de l'élément de la liste à ce qui suit
              onTap: () async {
                // Définit la station sélectionnée comme la station en cours
                provider.setRadioStation(station);
                // Enregistre la station sélectionnée dans les préférences partagées
                SharedPrefsApi.setStation(station);
                // Change la station en cours sur le lecteur de musique
                await RadioApi.changeStation(station);
                // Met à jour l'état pour afficher la station sélectionnée
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
