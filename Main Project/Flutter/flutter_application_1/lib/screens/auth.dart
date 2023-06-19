import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key});

  @override
  Widget build(BuildContext context) {
    // Retourne un Scaffold qui contient un StreamBuilder
    // Le StreamBuilder permet de recevoir des mises à jour de l'état de l'authentification Firebase
    return Scaffold(
      body: StreamBuilder<User?>(
        // Écoute les changements d'état de l'authentification Firebase
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Si un utilisateur est connecté, renvoie l'écran d'accueil (HomeScreen)
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            // Sinon, renvoie l'écran de connexion (LoginScreen)
            return LoginScreen();
          }
        },
      ),
    );
  }
}
