import 'package:cinelist/data/watchlist_repository.dart';
import 'package:cinelist/screens/add_movie_screen.dart';
import 'package:cinelist/screens/detail_screen.dart';
import 'package:cinelist/screens/home_screen.dart';
import 'package:cinelist/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Noms des routes, utilises avec `context.pushNamed(...)`.
///
/// Passer par un nom evite d'ecrire les chemins a la main dans les ecrans : si
/// une URL change, il n'y a que ce fichier a modifier.
class Routes {
  Routes._();

  static const String accueil = 'accueil';
  static const String detail = 'detail';
  static const String ajout = 'ajout';
  static const String watchlist = 'watchlist';
}

GoRouter createRouter(
  VoidCallback toggleTheme,
  WatchlistRepository watchlistRepository,
) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: Routes.accueil,
        builder: (context, state) => HomeScreen(toggleTheme: toggleTheme),
      ),
      GoRoute(
        path: '/detail/:id',
        name: Routes.detail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return DetailScreen(
            movieId: int.parse(id),
            watchlistRepository: watchlistRepository,
          );
        },
      ),
      GoRoute(
        path: '/add',
        name: Routes.ajout,
        builder: (context, state) =>
            AddMovieScreen(watchlistRepository: watchlistRepository),
      ),
      GoRoute(
        path: '/watchlist',
        name: Routes.watchlist,
        builder: (context, state) =>
            WatchlistScreen(watchlistRepository: watchlistRepository),
      ),
    ],
  );
}
