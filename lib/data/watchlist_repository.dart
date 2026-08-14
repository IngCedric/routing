import 'package:cinelist/models/movie.dart';

class WatchlistRepository {
  // valeurs par defaut d'un film ajoute a la main (donnees, pas de l'UI)
  static const String synopsisParDefaut =
      'Ajouté manuellement depuis la watchlist.';
  static const String posterParDefaut = '';

  final List<Movie> _films = [];

  List<Movie> getAll() => _films;

  // retourne un film ajoute par l'utilisateur, ou null s'il n'existe pas
  Movie? getById(int id) {
    return _films.where((f) => f.id == id).firstOrNull;
  }

  void ajouter(Movie film) {
    _films.add(film);
  }

  // construit et ajoute un film a partir des champs saisis dans le formulaire
  void ajouterDepuisFormulaire({
    required String titre,
    required String genre,
    required double note,
  }) {
    final film = Movie(
      DateTime.now().millisecondsSinceEpoch, // id unique simple
      titre,
      genre,
      null, // annee non demandee dans ce formulaire
      note,
      synopsisParDefaut,
      posterParDefaut,
    );
    ajouter(film);
  }
}
