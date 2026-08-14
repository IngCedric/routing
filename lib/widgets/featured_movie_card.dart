import 'package:cinelist/models/movie.dart';
import 'package:cinelist/theme/genre_style.dart';
import 'package:cinelist/widgets/rating_badge.dart';
import 'package:flutter/material.dart';

/// Grande carte panoramique utilisee dans le carrousel "A l'affiche".
///
/// Contrairement a [MovieCard], elle ne participe pas a l'animation partagee
/// vers l'ecran de detail : un meme film peut apparaitre a la fois ici et dans
/// la liste en dessous, et deux animations portant le meme tag entreraient en
/// conflit.
class FeaturedMovieCard extends StatelessWidget {
  final Movie film;
  final VoidCallback onTap;

  const FeaturedMovieCard({
    super.key,
    required this.film,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = GenreStyle.of(film.genre);

    return SizedBox(
      width: 290,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: style.degrade,
              ),
              boxShadow: [
                BoxShadow(
                  color: style.couleur.withValues(alpha: 0.34),
                  blurRadius: 22,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Icone du genre en filigrane
                Positioned(
                  right: -26,
                  bottom: -26,
                  child: Icon(
                    style.icone,
                    size: 150,
                    color: Colors.white.withValues(alpha: 0.16),
                  ),
                ),
                // Voile sombre en bas pour garantir la lisibilite du texte
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.45),
                        ],
                        stops: const [0.45, 1],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // La pastille de genre se retracte si le nom est
                          // long, pour laisser la place a la note.
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.22),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  film.genre.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          RatingBadge(note: film.note, surAffiche: true),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        film.titre,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          if (film.annee != null)
                            Text(
                              '${film.annee}',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          const Spacer(),
                          Text(
                            'Voir la fiche',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.95),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 15,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
