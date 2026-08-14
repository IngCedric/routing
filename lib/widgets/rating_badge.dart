import 'package:cinelist/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Pastille compacte affichant la note d'un film (une etoile + la valeur).
///
/// Utilisee sur les affiches et les cartes, la ou une rangee de cinq etoiles
/// prendrait trop de place.
class RatingBadge extends StatelessWidget {
  final double note;

  /// Affiche la pastille sur fond sombre translucide (sur une affiche) plutot
  /// que sur une surface du theme.
  final bool surAffiche;

  const RatingBadge({super.key, required this.note, this.surAffiche = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: surAffiche
            ? const Color(0xCC0B0E14)
            : colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: surAffiche
            ? Border.all(color: Colors.white.withValues(alpha: 0.16))
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 14, color: AppTheme.star),
          const SizedBox(width: 3),
          Text(
            note.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
              color: surAffiche ? Colors.white : colors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
