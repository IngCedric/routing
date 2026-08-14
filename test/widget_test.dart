// Tests de l'application CineList.
//
// On verifie les trois comportements demandes par l'enonce : l'affichage de la
// liste, la recherche/filtrage, et la validation du formulaire.

import 'package:cinelist/data/watchlist_repository.dart';
import 'package:cinelist/main.dart';
import 'package:cinelist/screens/add_movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('L\'accueil affiche le catalogue de films', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('CineList'), findsOneWidget);
    expect(find.text('Inception'), findsWidgets);
    expect(find.text('Parasite'), findsWidgets);
  });

  testWidgets('La recherche filtre la liste des films', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'parasite');
    await tester.pumpAndSettle();

    expect(find.text('Parasite'), findsOneWidget);
    expect(find.text('Inception'), findsNothing);
  });

  testWidgets('Le formulaire refuse les champs vides', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AddMovieScreen(watchlistRepository: WatchlistRepository()),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Le titre est obligatoire'), findsOneWidget);
    expect(find.text('Le genre est obligatoire'), findsOneWidget);
    expect(find.text('La note est obligatoire'), findsOneWidget);
  });

  testWidgets('Le formulaire refuse une note non numerique', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AddMovieScreen(watchlistRepository: WatchlistRepository()),
      ),
    );

    final champs = find.byType(TextFormField);
    await tester.enterText(champs.at(0), 'Blade Runner');
    await tester.enterText(champs.at(1), 'Science-Fiction');
    await tester.enterText(champs.at(2), 'abc');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('La note doit être un nombre valide'), findsOneWidget);
  });

  test('La watchlist enregistre un film ajoute depuis le formulaire', () {
    final repository = WatchlistRepository();

    repository.ajouterDepuisFormulaire(
      titre: 'Blade Runner',
      genre: 'Science-Fiction',
      note: 4.5,
    );

    expect(repository.getAll().length, 1);
    expect(repository.getAll().first.titre, 'Blade Runner');
    // Le film ajoute doit etre retrouvable par son id, pour l'ecran de detail.
    final id = repository.getAll().first.id;
    expect(repository.getById(id), isNotNull);
  });
}
