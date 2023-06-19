import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  // Le constructeur de la classe GradientBackground qui prend un Widget en entrée et une clé optionnelle
  const GradientBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity, // Hauteur du conteneur définie sur la hauteur maximale disponible
      width: double.infinity, // Largeur du conteneur définie sur la largeur maximale disponible
      decoration: const BoxDecoration(
        color: Color(0xFFF2E5DC), // Couleur de fond du conteneur (dégradé linéaire)
      ), // Décoration du conteneur qui contient la couleur de fond
      child: child, // Le widget enfant qui sera placé à l'intérieur du conteneur
    ); // Le conteneur lui-même qui sera retourné
  }
}
