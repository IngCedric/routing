import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double note;
  final double size;

  const RatingStars({super.key, required this.note, this.size = 20});

  @override
  Widget build(BuildContext context) {
    final int nombreEtoile;
    // arrondir ma double en int pour savoir le nombre d'etoile a afficher
    nombreEtoile = note.round();

    final etoiles = List.generate(
      nombreEtoile,
      ((index) => Icon(Icons.star_rounded, color: Colors.amber, size: size)),
    );

    final etoilesVide = 5 - etoiles.length;
    final listeEtoileVide = List.generate(
      etoilesVide,
      ((index) => Icon(Icons.star_rounded, color: Colors.grey.shade300, size: size)),
    );

    final listeFinal = etoiles + listeEtoileVide;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...listeFinal,
        SizedBox(width: size * 0.3),
        Text(
          note.toStringAsFixed(1),
          style: TextStyle(
            fontSize: size * 0.75,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
