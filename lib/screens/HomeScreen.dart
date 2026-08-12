import 'package:cinelist/data/movies_repository.dart';
import 'package:cinelist/models/movie.dart';
import 'package:cinelist/widgets/genre_chip.dart';
import 'package:cinelist/widgets/movie_card.dart';
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
    final films = repository
        .getAll()
        .where((m) => m.titre.toLowerCase().contains(_recherche.toLowerCase()))
        .where((m) => _genreSelectionne == null || m.genre == _genreSelectionne)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('CineList'),
        actions: [
          IconButton(
            onPressed: () => context.push('/add'),
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () => widget.toggleTheme(),
            icon: const Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Rechercher un film...',
                prefixIcon: Icon(Icons.search_rounded),
              ),
              onChanged: (value) {
                setState(() {
                  _recherche = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: repository.genres
                  .map(
                    (genre) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GenreChip(
                        genre: genre,
                        selected: _genreSelectionne == genre,
                        onSelected: (value) {
                          setState(() {
                            _genreSelectionne = value ? genre : null;
                          });
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: films.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.movie_filter_outlined,
                          size: 56,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Aucun film ne correspond à ta recherche',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 600) {
                        // MOBILE : liste verticale simple
                        return ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                          itemCount: films.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final film = films[index];
                            return MovieCard(
                              film: film,
                              onTap: () => context.push('/detail/${film.id}'),
                            );
                          },
                        );
                      } else {
                        // TABLETTE : grille
                        return GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 92,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                          itemCount: films.length,
                          itemBuilder: (context, index) {
                            final film = films[index];
                            return MovieCard(
                              film: film,
                              onTap: () => context.push('/detail/${film.id}'),
                            );
                          },
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
