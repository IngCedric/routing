import 'package:cinelist/data/watchlist_repository.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un film')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Ajoute un film à ta liste',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  prefixIcon: Icon(Icons.movie_outlined),
                ),
                controller: _titreController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le titre est obligatoire';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Genre',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                controller: _genreController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le genre est obligatoire';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Note',
                  prefixIcon: Icon(Icons.star_outline_rounded),
                ),
                controller: _noteController,
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
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.watchlistRepository.ajouterDepuisFormulaire(
                        titre: _titreController.text,
                        genre: _genreController.text,
                        note: double.parse(_noteController.text),
                      );
                      context.push('/watchlist');
                    }
                  },
                  child: const Text('Valider'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
