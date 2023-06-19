import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/apis/radio_api.dart';
import 'package:flutter_application_1/widgets/gradient_background.dart';
import 'package:flutter_application_1/widgets/radio_player.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
// Affichage de l'arrière-plan en dégradé et de la colonne principale de la page
    return GradientBackground(
      child: Column(
        children: [
// Section d'entête contenant l'image de l'utilisateur et le bouton de déconnexion
          Container(
            padding: EdgeInsets.fromLTRB(30, 60, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
// Image de profil et nom d'utilisateur
                Column(
                  children: [
                    Image(
                      image: AssetImage('images/old-man.png'),
                      width: 70,
                      height:70,
                    ),
                    Text(
                      user!.email!.split('@')[0],
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
// Bouton de déconnexion
                MaterialButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut(); // Déconnexion de l'utilisateur
                    RadioApi.stop(); // Arrêt de la station de radio
                  },
                  color: Colors.amber[900],
                  child: Text('Log Out',
                    style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Section principale de la page contenant le lecteur de la station de radio
          Expanded(
            child: FutureBuilder(
                future: RadioApi.initPlayer(context),
                builder: (context ,snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    // Affichage d'un cercle de chargement si la connexion est en attente
                    return const Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white,),);
                  }
                  // Affichage du lecteur de la station de radio
                  return RadioPlayer();
                }
            ),
          ),
        ],
      ),
    );

  }
}
