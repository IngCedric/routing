import 'package:cinelist/data/watchlist_repository.dart';
import 'package:cinelist/widgets/empty_state.dart';
import 'package:cinelist/widgets/fade_slide_in.dart';
import 'package:cinelist/widgets/movie_card.dart';
import 'package:cinelist/widgets/section_header.dart';
import 'package:cinelist/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WatchlistScreen extends StatelessWidget {
  final WatchlistRepository watchlistRepository;

  const WatchlistScreen({super.key, required this.watchlistRepository});

  @override
  Widget build(BuildContext context) {
    final films = watchlistRepository.getAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma watchlist'),
        actions: [
          IconButton(
            tooltip: 'Ajouter un film',
            onPressed: () => context.pushNamed(Routes.ajout),
            icon: const Icon(Icons.add_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: films.isEmpty
          ? const EmptyState(
              icone: Icons.bookmark_border_rounded,
              titre: 'Ta watchlist est vide',
              message:
                  'Ajoute un film depuis le bouton + pour le retrouver ici.',
            )
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                  itemCount: films.length + 1,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: SectionHeader(
                          titre: 'Films enregistrés',
                          compteur: '${films.length}',
                        ),
                      );
                    }

                    final film = films[index - 1];
                    return FadeSlideIn(
                      index: index - 1,
                      child: MovieCard(
                        film: film,
                        onTap: () => context.pushNamed(Routes.detail, pathParameters: {'id': '${film.id}'}),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
