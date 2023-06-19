import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

// Controllers pour les champs de texte email et password
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

// Fonction pour la connexion de l'utilisateur avec Firebase Auth
  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
  }

// Fonction pour aller à l'écran d'inscription
  void openSignupscreen() {
    Navigator.of(context).pushReplacementNamed('signupScreen');
  }

  @override
  void dispose(){
    super.dispose();
// Libérer les contrôleurs lorsqu'on n'en a plus besoin
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF2E5DC),
      body: SafeArea(
        child:Center(
          child:SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image du logo
                Image.asset('images/old.png', height: 240),

                // Titre de l'écran de connexion
                Column(
                  children: [
                    Text(
                      'SIGN IN',
                      style: GoogleFonts.openSans(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),

                    // Sous-titre de l'écran de connexion
                    Text(
                      'Welcome back! Nice to see you again',
                      style:GoogleFonts.openSans(fontSize: 17),
                    ),
                  ],
                ),

                SizedBox(
                  height: 50,
                ),

                // Champ de texte pour l'email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                        style: GoogleFonts.openSans(fontSize: 30),
                      ),
                    ),
                  ),
                ),

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
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                        style: GoogleFonts.openSans(fontSize: 30),
                      ),
                    ),
                  ),
                ),

                // Bouton pour se connecter
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Sign in',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Not yet a member?',
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            GestureDetector(
              onTap: openSignupscreen,
              child: Text(
                  '   Sign up now',
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
