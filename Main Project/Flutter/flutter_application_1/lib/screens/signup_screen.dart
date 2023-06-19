// ignore_for_file: prefer_const_constructors
// Ce fichier contient le code de l'écran d'inscription
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen ({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Les contrôleurs de texte pour les champs d'entrée
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // Cette méthode envoie les informations d'inscription à Firebase
  Future signUp() async{
    if(passwordConfirmed()){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
      Navigator.of(context).pushNamed('loginScreen');
    }
  }
  // Cette méthode vérifie si le mot de passe et la confirmation de mot de passe sont identiques
  bool passwordConfirmed(){
    if(_passwordController.text.trim() == _confirmPasswordController.text.trim()){
      return true;
    }
    else{
      return false;
    }
  }
  // Cette méthode ouvre l'écran d'inscription
  void openSignupscreen() {
    Navigator.of(context).pushReplacementNamed('signupScreen');
  }
  // Cette méthode ouvre l'écran de connexion
  void openSigninscreen() {
    Navigator.of(context).pushReplacementNamed('loginScreen');
  }
  // Cette méthode est appelée lorsque l'écran est détruit pour éviter les fuites de mémoire
  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

  }
  // Cette méthode construit l'interface utilisateur de l'écran d'inscription
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF2E5DC), // Couleur de fond du Scaffold
      body: SafeArea(
        child:Center(
          child:SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centre les éléments verticalement
              children: [
                Image.asset('images/old.png', height: 170), // Image à partir d'un fichier dans le dossier "images"
                // Titre
                Column(
                  children: [
                    Text(
                      'SIGN UP', // Texte du titre
                      style: GoogleFonts.openSans(
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    // Sous-titre
                    Text(
                      'Welcome ! Here you can sign up', // Texte du sous-titre
                      style:GoogleFonts.openSans(fontSize: 18),
                    ),
                  ],
                ),

                SizedBox(
                  height: 50, // Espace vertical entre les éléments
                ),

                // Champ de texte pour l'adresse e-mail
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Couleur de fond du champ de texte
                      borderRadius: BorderRadius.circular(12), // Coins arrondis
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _emailController, // Contrôleur pour récupérer la valeur du champ de texte
                        decoration: InputDecoration(
                          border: InputBorder.none, // Supprime la bordure du champ de texte
                          hintText: 'Email', // Texte d'indication
                        ),
                        style: GoogleFonts.openSans(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),

                // Champ de texte pour le mot de passe
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true, // Masque le texte saisi
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                        style: GoogleFonts.openSans(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Champ de texte pour la confirmation du mot de passe
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                        ),
                        style: GoogleFonts.openSans(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Bouton de connexion
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: signUp, // Fonction appelée lorsqu'on appuie sur le bouton
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber[900], // Couleur de fond du bouton
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ), // TextStyle
                        ), // Text
                      ), // Center
                    ), // Container
                  ),
                ),// Padding
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    GestureDetector(
                      onTap: openSigninscreen,
                      child: Text(
                        '    Sign in here',
                        style: GoogleFonts.openSans(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
