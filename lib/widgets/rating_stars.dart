import 'package:cinelist/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Note d'un film affichee sous forme de cinq etoiles.
///
/// Les demi-points sont rendus par une etoile a moitie pleine, pour que 4.5 et
/// 4.9 ne se ressemblent pas.
class RatingStars extends StatelessWidget {
  final double note;
  final double size;

  /// Affiche la valeur chiffree a droite des etoiles.
  final bool afficherValeur;

  const RatingStars({
    super.key,
    required this.note,
    this.size = 20,
    this.afficherValeur = true,
  });

  @override
  Widget build(BuildContext context) {
    final couleurVide = Theme.of(context).colorScheme.outlineVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int position = 1; position <= 5; position++)
          Icon(_icone(position), size: size, color: _couleur(position, couleurVide)),
        if (afficherValeur) ...[
          SizedBox(width: size * 0.3),
          Text(
            note.toStringAsFixed(1),
            style: TextStyle(
              fontSize: size * 0.7,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }

  IconData _icone(int position) {
    if (note >= position) return Icons.star_rounded;
    if (note >= position - 0.5) return Icons.star_half_rounded;
    return Icons.star_rounded;
  }

  Color _couleur(int position, Color couleurVide) {
    return note >= position - 0.5 ? AppTheme.star : couleurVide;
  }
}
