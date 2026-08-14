import 'package:cinelist/data/watchlist_repository.dart';
import 'package:cinelist/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddMovieScreen extends StatefulWidget {
  final WatchlistRepository watchlistRepository;

  const AddMovieScreen({super.key, required this.watchlistRepository});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titreController = TextEditingController();
  final _genreController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un film')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _entete(theme),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: theme.colorScheme.outlineVariant),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Titre',
                            hintText: 'Ex. : Blade Runner',
                            prefixIcon: Icon(Icons.movie_outlined),
                          ),
                          controller: _titreController,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Le titre est obligatoire';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Genre',
                            hintText: 'Ex. : Science-Fiction',
                            prefixIcon: Icon(Icons.category_outlined),
                          ),
                          controller: _genreController,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Le genre est obligatoire';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Note',
                            hintText: 'De 0 à 5, ex. : 4.5',
                            prefixIcon: Icon(Icons.star_outline_rounded),
                          ),
                          controller: _noteController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'La note est obligatoire';
                            }
                            if (double.tryParse(value) == null) {
                              return 'La note doit être un nombre valide';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.watchlistRepository.ajouterDepuisFormulaire(
                            titre: _titreController.text,
                            genre: _genreController.text,
                            note: double.parse(_noteController.text),
                          );
                          context.pushNamed(Routes.watchlist);
                        }
                      },
                      icon: const Icon(Icons.bookmark_add_rounded, size: 19),
                      label: const Text('Ajouter à ma watchlist'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _entete(ThemeData theme) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.primary.withValues(alpha: 0.6),
              ],
            ),
          ),
          child: Icon(
            Icons.add_rounded,
            color: theme.colorScheme.onPrimary,
            size: 24,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nouveau film', style: theme.textTheme.titleLarge),
              const SizedBox(height: 3),
              Text(
                'Les trois champs sont obligatoires.',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
