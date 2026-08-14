import 'package:cinelist/data/movies_repository.dart';
import 'package:cinelist/models/movie.dart';
import 'package:cinelist/widgets/empty_state.dart';
import 'package:cinelist/widgets/fade_slide_in.dart';
import 'package:cinelist/widgets/featured_movie_card.dart';
import 'package:cinelist/widgets/genre_chip.dart';
import 'package:cinelist/widgets/movie_card.dart';
import 'package:cinelist/widgets/section_header.dart';
import 'package:cinelist/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  const HomeScreen({super.key, required this.toggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _recherche = '';
  String? _genreSelectionne;
  final repository = MoviesRepository();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sombre = theme.brightness == Brightness.dark;

    final tousLesFilms = repository.getAll();

    final films = tousLesFilms
        .where((m) => m.titre.toLowerCase().contains(_recherche.toLowerCase()))
        .where((m) => _genreSelectionne == null || m.genre == _genreSelectionne)
        .toList();

    // Les trois films les mieux notes alimentent le carrousel.
    final aLAffiche =
        (tousLesFilms.toList()..sort((a, b) => b.note.compareTo(a.note)))
            .take(3)
            .toList();

    final filtreActif = _recherche.isNotEmpty || _genreSelectionne != null;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final largeEcran = constraints.maxWidth >= 600;
          final colonnes = constraints.maxWidth >= 1000 ? 3 : 2;
          final marge = largeEcran ? 24.0 : 16.0;

          return CustomScrollView(
            slivers: [
              _barre(theme, sombre),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(marge, 4, marge, 14),
                sliver: SliverToBoxAdapter(child: _champRecherche()),
              ),
              SliverToBoxAdapter(child: _filtresGenre(marge)),
              if (!filtreActif) ...[
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(marge, 26, marge, 14),
                  sliver: const SliverToBoxAdapter(
                    child: SectionHeader(titre: 'À l\'affiche'),
                  ),
                ),
                SliverToBoxAdapter(child: _carrousel(aLAffiche, marge)),
              ],
              SliverPadding(
                padding: EdgeInsets.fromLTRB(marge, 26, marge, 14),
                sliver: SliverToBoxAdapter(
                  child: SectionHeader(
                    titre: filtreActif ? 'Résultats' : 'Tout le catalogue',
                    compteur: '${films.length}',
                  ),
                ),
              ),
              if (films.isEmpty)
                const SliverToBoxAdapter(
                  child: EmptyState(
                    icone: Icons.search_off_rounded,
                    titre: 'Aucun film trouvé',
                    message:
                        'Essaie un autre titre, ou retire le filtre de genre.',
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(marge, 0, marge, 32),
                  sliver: largeEcran
                      ? _grille(films, colonnes)
                      : _liste(films),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _barre(ThemeData theme, bool sombre) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 118,
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 20, bottom: 15, right: 20),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withValues(alpha: 0.62),
                  ],
                ),
              ),
              child: Icon(
                Icons.local_movies_rounded,
                size: 17,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 10),
            Text('CineList', style: theme.appBarTheme.titleTextStyle),
          ],
        ),
      ),
      actions: [
        IconButton(
          tooltip: 'Ma watchlist',
          onPressed: () => context.pushNamed(Routes.watchlist),
          icon: const Icon(Icons.bookmark_border_rounded),
        ),
        IconButton(
          tooltip: 'Ajouter un film',
          onPressed: () => context.pushNamed(Routes.ajout),
          icon: const Icon(Icons.add_rounded),
        ),
        IconButton(
          tooltip: sombre ? 'Thème clair' : 'Thème sombre',
          onPressed: widget.toggleTheme,
          icon: Icon(
            sombre ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          ),
        ),
        const SizedBox(width: 6),
      ],
    );
  }

  Widget _champRecherche() {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Rechercher un film...',
        prefixIcon: Icon(Icons.search_rounded),
      ),
      onChanged: (value) {
        setState(() {
          _recherche = value;
        });
      },
    );
  }

  Widget _filtresGenre(double marge) {
    final genres = repository.genres.toList();

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: marge),
        itemCount: genres.length + 1,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          // La premiere puce remet le filtre a zero.
          if (index == 0) {
            return GenreChip(
              genre: 'Tous',
              selected: _genreSelectionne == null,
              onSelected: (_) => setState(() => _genreSelectionne = null),
            );
          }

          final genre = genres[index - 1];
          return GenreChip(
            genre: genre,
            selected: _genreSelectionne == genre,
            onSelected: (value) {
              setState(() {
                _genreSelectionne = value ? genre : null;
              });
            },
          );
        },
      ),
    );
  }

  Widget _carrousel(List<Movie> films, double marge) {
    return SizedBox(
      height: 168,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: marge),
        itemCount: films.length,
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final film = films[index];
          return FadeSlideIn(
            index: index,
            child: FeaturedMovieCard(
              film: film,
              onTap: () => context.pushNamed(Routes.detail, pathParameters: {'id': '${film.id}'}),
            ),
          );
        },
      ),
    );
  }

  Widget _liste(List<Movie> films) {
    return SliverList.separated(
      itemCount: films.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final film = films[index];
        return FadeSlideIn(
          index: index,
          child: MovieCard(
            film: film,
            onTap: () => context.pushNamed(Routes.detail, pathParameters: {'id': '${film.id}'}),
          ),
        );
      },
    );
  }

  Widget _grille(List<Movie> films, int colonnes) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: colonnes,
        mainAxisExtent: 116,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: films.length,
      itemBuilder: (context, index) {
        final film = films[index];
        return FadeSlideIn(
          index: index,
          child: MovieCard(
            film: film,
            onTap: () => context.pushNamed(Routes.detail, pathParameters: {'id': '${film.id}'}),
          ),
        );
      },
    );
  }
}
