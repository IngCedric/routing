import 'package:cinelist/models/movie.dart';
import 'package:cinelist/theme/genre_style.dart';
import 'package:flutter/material.dart';

/// Affiche generee d'un film.
///
/// Le catalogue ne fournit pas de vraie image, donc l'affiche est construite a
/// partir du genre : un degrade, une icone en filigrane et les initiales du
/// titre.
class MoviePoster extends StatelessWidget {
  final Movie film;

  /// Largeur de l'affiche. La hauteur suit le ratio 2:3 des affiches de cinema.
  final double largeur;

  /// Tag d'animation partagee avec l'ecran de detail. Laisser nul pour
  /// desactiver l'animation.
  final String? heroTag;

  const MoviePoster({
    super.key,
    required this.film,
    this.largeur = 60,
    this.heroTag,
  });

  String get _initiales {
    final mots = film.titre.trim().split(RegExp(r'\s+'));
    final lettres = mots
        .where((m) => m.isNotEmpty)
        .take(2)
        .map((m) => m[0])
        .join();
    return lettres.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final style = GenreStyle.of(film.genre);
    final hauteur = largeur * 1.5;
    final rayon = largeur * 0.22;

    final affiche = Container(
      width: largeur,
      height: hauteur,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(rayon),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: style.degrade,
        ),
        boxShadow: [
          BoxShadow(
            color: style.couleur.withValues(alpha: 0.32),
            blurRadius: largeur * 0.28,
            offset: Offset(0, largeur * 0.1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(rayon),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Halo lumineux en haut a gauche
            Positioned(
              top: -hauteur * 0.2,
              left: -largeur * 0.3,
              child: Container(
                width: largeur * 1.1,
                height: largeur * 1.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.16),
                ),
              ),
            ),
            // Icone du genre en filigrane
            Positioned(
              right: -largeur * 0.12,
              bottom: -largeur * 0.12,
              child: Icon(
                style.icone,
                size: largeur * 0.78,
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
            Center(
              child: Text(
                _initiales,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: largeur * 0.36,
                  letterSpacing: -1,
                  shadows: const [
                    Shadow(color: Color(0x40000000), blurRadius: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (heroTag == null) return affiche;
    return Hero(tag: heroTag!, child: affiche);
  }
}
