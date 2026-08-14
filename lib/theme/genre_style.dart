import 'package:flutter/material.dart';

/// Identite visuelle d'un genre : un degrade et une icone.
///
/// Les films du catalogue n'ont pas de vraie affiche, donc chaque affiche est
/// generee a partir de son genre. Deux films du meme genre partagent la meme
/// ambiance de couleur, ce qui rend la liste lisible d'un coup d'oeil.
class GenreStyle {
  final List<Color> degrade;
  final IconData icone;

  const GenreStyle({required this.degrade, required this.icone});

  Color get couleur => degrade.first;

  /// Retourne le style d'un genre connu, ou un style de repli stable pour un
  /// genre saisi par l'utilisateur (le meme genre donne toujours le meme
  /// resultat).
  static GenreStyle of(String genre) {
    final connu = _styles[genre.toLowerCase().trim()];
    if (connu != null) return connu;

    final empreinte = genre.codeUnits.fold<int>(0, (a, b) => a + b);
    return _repli[empreinte % _repli.length];
  }

  static const Map<String, GenreStyle> _styles = {
    'science-fiction': GenreStyle(
      degrade: [Color(0xFF4F6BFF), Color(0xFF9C4FFF)],
      icone: Icons.rocket_launch_rounded,
    ),
    'fantastique': GenreStyle(
      degrade: [Color(0xFF7B5CFF), Color(0xFFE05CC8)],
      icone: Icons.auto_awesome_rounded,
    ),
    'drame': GenreStyle(
      degrade: [Color(0xFF2F5D8C), Color(0xFF4E8FA8)],
      icone: Icons.theater_comedy_rounded,
    ),
    'comédie musicale': GenreStyle(
      degrade: [Color(0xFFFF7A45), Color(0xFFFFB84F)],
      icone: Icons.music_note_rounded,
    ),
    'comedie musicale': GenreStyle(
      degrade: [Color(0xFFFF7A45), Color(0xFFFFB84F)],
      icone: Icons.music_note_rounded,
    ),
    'horreur': GenreStyle(
      degrade: [Color(0xFF8E1F3D), Color(0xFF3B1030)],
      icone: Icons.nightlight_round,
    ),
    'action': GenreStyle(
      degrade: [Color(0xFFE23E3E), Color(0xFFFF8A3D)],
      icone: Icons.local_fire_department_rounded,
    ),
    'comédie': GenreStyle(
      degrade: [Color(0xFFFFB020), Color(0xFFFFD86B)],
      icone: Icons.mood_rounded,
    ),
    'animation': GenreStyle(
      degrade: [Color(0xFF00B894), Color(0xFF63E6BE)],
      icone: Icons.animation_rounded,
    ),
    'thriller': GenreStyle(
      degrade: [Color(0xFF1F3A5F), Color(0xFF5A3E8C)],
      icone: Icons.visibility_off_rounded,
    ),
    'romance': GenreStyle(
      degrade: [Color(0xFFE84393), Color(0xFFFF9FC4)],
      icone: Icons.favorite_rounded,
    ),
    'documentaire': GenreStyle(
      degrade: [Color(0xFF2D9CDB), Color(0xFF56CCF2)],
      icone: Icons.public_rounded,
    ),
  };

  static const List<GenreStyle> _repli = [
    GenreStyle(
      degrade: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
      icone: Icons.movie_rounded,
    ),
    GenreStyle(
      degrade: [Color(0xFF00A8A0), Color(0xFF4FD1C5)],
      icone: Icons.local_movies_rounded,
    ),
    GenreStyle(
      degrade: [Color(0xFFD35400), Color(0xFFF39C12)],
      icone: Icons.theaters_rounded,
    ),
    GenreStyle(
      degrade: [Color(0xFF34495E), Color(0xFF5D7A99)],
      icone: Icons.video_library_rounded,
    ),
  ];
}
