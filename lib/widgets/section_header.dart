import 'package:flutter/material.dart';

/// Titre de section, avec un compteur optionnel a droite.
class SectionHeader extends StatelessWidget {
  final String titre;
  final String? compteur;

  const SectionHeader({super.key, required this.titre, this.compteur});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(titre, style: theme.textTheme.titleLarge)),
        if (compteur != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              compteur!,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}
