import 'package:cinelist/data/watchlist_repository.dart';
import 'package:cinelist/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WatchlistScreen extends StatelessWidget {
  final WatchlistRepository watchlistRepository;

  const WatchlistScreen({super.key, required this.watchlistRepository});

  @override
  Widget build(BuildContext context) {
    final films = watchlistRepository.getAll();

    return Scaffold(
      appBar: AppBar(title: const Text('Ma Watchlist')),
      body: films.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bookmark_border_rounded,
                    size: 56,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Aucun film dans votre watchlist',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: films.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final film = films[index];
                return MovieCard(
                  film: film,
                  onTap: () => context.push('/detail/${film.id}'),
                );
              },
            ),
    );
  }
}
