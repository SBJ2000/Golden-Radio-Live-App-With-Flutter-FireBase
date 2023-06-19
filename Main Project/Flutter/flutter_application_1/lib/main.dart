// Import des packages nécessaires
import 'package:flutter_application_1/models/radio_station.dart'; // Modèle de données d'une station de radio
import 'package:flutter_application_1/providers/radio_provider.dart'; // Classe Provider pour la gestion des stations de radio
import 'package:flutter_application_1/screens/auth.dart'; // Ecran d'authentification
import 'package:flutter_application_1/screens/home_screen.dart'; // Ecran d'accueil
import 'package:flutter_application_1/screens/login_screen.dart'; // Ecran de connexion
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Initialisation de Firebase
import 'package:flutter_application_1/screens/signup_screen.dart'; // Ecran d'inscription
import 'package:provider/provider.dart'; // Gestion des providers
import 'package:cloud_firestore/cloud_firestore.dart'; // Base de données Firestore de Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialisation de Firebase
  final firebaseRadioStations = await getRadioStationsFromFirebase(); // Récupération des stations de radio depuis Firebase
  final initialStation = firebaseRadioStations.isNotEmpty ? firebaseRadioStations.first : RadioStation.empty(); // Choix de la première station ou station vide si aucune station n'est récupérée

  runApp(MyApp(initialStation: initialStation)); // Lancement de l'application Flutter avec la station de radio initiale choisie
}

// Fonction asynchrone pour récupérer les stations de radio depuis Firebase
Future<List<RadioStation>> getRadioStationsFromFirebase() async {
  final snapshot = await FirebaseFirestore.instance.collection('radio_stations').get(); // Récupération de tous les documents de la collection 'radio_stations' dans Firestore
  final radioStations = snapshot.docs.map((doc) => RadioStation.fromJson(doc.data())).toList(); // Conversion de chaque document en objet RadioStation en utilisant la méthode fromJson
  return radioStations; // Renvoi de la liste des stations de radio récupérées depuis Firebase
}

// Classe principale de l'application Flutter
class MyApp extends StatelessWidget {
  final RadioStation initialStation;

  const MyApp({Key? key, required this.initialStation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:  ((context)=> RadioProvider(initialStation))) // Utilisation de la classe RadioProvider pour la gestion des stations de radio
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Désactivation de la bannière de débogage
        theme: ThemeData(
          primarySwatch: Colors.blue, // Définition de la couleur principale de l'application
        ),
        routes: {
          '/':(context) => const Auth(), // Ecran d'authentification
          'homeScreen': (context) => const HomeScreen(), // Ecran d'accueil
          'signupScreen':(context) => const SignupScreen(), // Ecran d'inscription
          'loginScreen': (context) => const LoginScreen(), // Ecran de connexion
        },
      ),
    );
  }
} 
