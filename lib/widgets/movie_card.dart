import 'package:cinelist/models/movie.dart';
import 'package:cinelist/theme/genre_style.dart';
import 'package:cinelist/widgets/movie_poster.dart';
import 'package:cinelist/widgets/rating_stars.dart';
import 'package:flutter/material.dart';

/// Carte d'un film dans une liste ou une grille : affiche, titre, genre et note.
class MovieCard extends StatelessWidget {
  final Movie film;
  final VoidCallback onTap;

  const MovieCard({super.key, required this.film, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = GenreStyle.of(film.genre);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              MoviePoster(
                film: film,
                largeur: 56,
                heroTag: 'affiche-${film.id}',
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      film.titre,
                      style: theme.textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(style.icone, size: 13, color: style.couleur),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            film.annee != null
                                ? '${film.genre}  ·  ${film.annee}'
                                : film.genre,
                            style: theme.textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    RatingStars(note: film.note, size: 14),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
