import 'package:cinelist/theme/genre_style.dart';
import 'package:flutter/material.dart';

/// Puce de genre, utilisable comme filtre (avec `onSelected`) ou comme simple
/// etiquette (sans `onSelected`, sur l'ecran de detail).
///
/// La couleur reprend celle du genre, ce qui relie la puce aux affiches.
class GenreChip extends StatelessWidget {
  final String genre;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  const GenreChip({
    super.key,
    required this.genre,
    this.onSelected,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final style = GenreStyle.of(genre);

    final contenu = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: selected
            ? LinearGradient(colors: style.degrade)
            : null,
        color: selected ? null : colors.surfaceContainerHigh,
        border: Border.all(
          color: selected ? Colors.transparent : colors.outlineVariant,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: style.couleur.withValues(alpha: 0.38),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            style.icone,
            size: 14,
            color: selected ? Colors.white : style.couleur,
          ),
          const SizedBox(width: 6),
          Text(
            genre,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.1,
              color: selected ? Colors.white : colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );

    if (onSelected == null) return contenu;

    return GestureDetector(
      onTap: () => onSelected!(!selected),
      child: contenu,
    );
  }
}
