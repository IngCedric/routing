import 'package:cinelist/data/movies_repository.dart';
import 'package:cinelist/data/watchlist_repository.dart';
import 'package:cinelist/models/movie.dart';
import 'package:cinelist/theme/genre_style.dart';
import 'package:cinelist/widgets/empty_state.dart';
import 'package:cinelist/widgets/genre_chip.dart';
import 'package:cinelist/widgets/movie_poster.dart';
import 'package:cinelist/widgets/rating_stars.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.movieId,
    required this.watchlistRepository,
  });

  final int movieId;
  final WatchlistRepository watchlistRepository;

  @override
  Widget build(BuildContext context) {
    // Le film vient du catalogue, ou de la watchlist s'il a ete ajoute a la
    // main : les deux sources ont leurs propres identifiants.
    final film =
        MoviesRepository().getById(movieId) ??
        watchlistRepository.getById(movieId);

    if (film == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Film introuvable')),
        body: EmptyState(
          icone: Icons.search_off_rounded,
          titre: 'Film introuvable',
          message: 'Aucun film ne porte l\'identifiant $movieId.',
        ),
      );
    }

    final theme = Theme.of(context);
    final style = GenreStyle.of(film.genre);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _enTete(context, film, style),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(film.titre, style: theme.textTheme.displaySmall),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          GenreChip(genre: film.genre),
                          if (film.annee != null) _pastilleAnnee(theme, film),
                        ],
                      ),
                      const SizedBox(height: 22),
                      _bandeauNote(theme, film, style),
                      const SizedBox(height: 28),
                      Text('Synopsis', style: theme.textTheme.titleLarge),
                      const SizedBox(height: 10),
                      Text(film.synopsis, style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 28),
                      Text('Informations', style: theme.textTheme.titleLarge),
                      const SizedBox(height: 12),
                      _tableauInfos(theme, film),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// En-tete degrade reprenant les couleurs du genre, avec l'affiche au centre.
  Widget _enTete(BuildContext context, Movie film, GenreStyle style) {
    final colors = Theme.of(context).colorScheme;

    return SliverAppBar(
      pinned: true,
      expandedHeight: 300,
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: style.degrade,
                ),
              ),
            ),
            Positioned(
              right: -50,
              top: -30,
              child: Icon(
                style.icone,
                size: 240,
                color: Colors.white.withValues(alpha: 0.13),
              ),
            ),
            // Fondu vers le fond de l'ecran, pour souder l'en-tete au contenu.
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.22),
                      Colors.transparent,
                      colors.surface,
                    ],
                    stops: const [0, 0.55, 1],
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.18),
              child: MoviePoster(
                film: film,
                largeur: 118,
                heroTag: 'affiche-${film.id}',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pastilleAnnee(ThemeData theme, Movie film) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_rounded,
            size: 13,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 6),
          Text(
            '${film.annee}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  /// Grande note a gauche, etoiles a droite.
  Widget _bandeauNote(ThemeData theme, Movie film, GenreStyle style) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.surfaceContainer,
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Text(
            film.note.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              letterSpacing: -2,
              height: 1,
              color: style.couleur,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 2),
            child: Text('/5', style: theme.textTheme.bodySmall),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RatingStars(note: film.note, size: 19, afficherValeur: false),
              const SizedBox(height: 6),
              Text('Note du public', style: theme.textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tableauInfos(ThemeData theme, Movie film) {
    final lignes = <(String, String)>[
      ('Genre', film.genre),
      ('Année', film.annee?.toString() ?? 'Non renseignée'),
      ('Note', '${film.note.toStringAsFixed(1)} / 5'),
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.surfaceContainer,
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          for (int i = 0; i < lignes.length; i++) ...[
            if (i > 0) const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 15,
              ),
              child: Row(
                children: [
                  Text(lignes[i].$1, style: theme.textTheme.bodySmall),
                  const Spacer(),
                  Text(
                    lignes[i].$2,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
