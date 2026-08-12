import 'package:cinelist/data/watchlist_repository.dart';
import 'package:cinelist/screens/AddMovieScreen.dart';
import 'package:cinelist/screens/DetailScreen.dart';
import 'package:cinelist/screens/HomeScreen.dart';
import 'package:cinelist/screens/WatchlistScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter(
  VoidCallback toggleTheme,
  WatchlistRepository watchlistRepository,
) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(toggleTheme: toggleTheme),
      ),
      GoRoute(
        path: '/detail/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return DetailScreen(movieId: int.parse(id));
        },
      ),
      GoRoute(
        path: '/add',
        builder: (context, state) =>
            AddMovieScreen(watchlistRepository: watchlistRepository),
      ),
      GoRoute(
        path: '/watchlist',
        builder: (context, state) =>
            WatchlistScreen(watchlistRepository: watchlistRepository),
      ),
    ],
  );
}
