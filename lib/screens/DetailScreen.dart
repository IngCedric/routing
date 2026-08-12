import 'package:cinelist/data/movies_repository.dart';
import 'package:cinelist/widgets/genre_chip.dart';
import 'package:cinelist/widgets/rating_stars.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    final film = MoviesRepository().getById(movieId);

    final theme = Theme.of(context);

    if (film == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Film introuvable')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 56,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 12),
              Text('Aucun film avec l\'id $movieId'),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(film.titre)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              color: theme.colorScheme.surfaceContainerHigh,
              child: Column(
                children: [
                  Icon(
                    Icons.movie_rounded,
                    size: 56,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  RatingStars(note: film.note, size: 22),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(film.titre, style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      GenreChip(genre: film.genre),
                      if (film.annee != null)
                        Chip(label: Text('${film.annee}')),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Synopsis', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(film.synopsis, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
