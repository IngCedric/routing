import 'package:flutter/material.dart';

/// Message affiche quand une liste est vide, avec une icone mise en valeur.
class EmptyState extends StatelessWidget {
  final IconData icone;
  final String titre;
  final String? message;

  const EmptyState({
    super.key,
    required this.icone,
    required this.titre,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.22),
                    theme.colorScheme.primary.withValues(alpha: 0.06),
                  ],
                ),
              ),
              child: Icon(icone, size: 42, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 22),
            Text(
              titre,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
