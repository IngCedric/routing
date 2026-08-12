import 'package:cinelist/models/movie.dart';

class MoviesRepository {
  final List<Movie> _maListe = [
    Movie(
      1,
      'Inception',
      'Science-Fiction',
      2010,
      4.8,
      'Un voleur qui s\'infiltre dans les rêves des autres se voit confier une mission impossible : implanter une idée plutôt que de la voler.',
      'https://example.com/posters/inception.jpg',
    ),
    Movie(
      2,
      'Le Seigneur des Anneaux : La Communauté de l\'Anneau',
      'Fantastique',
      2001,
      4.9,
      'Un jeune hobbit hérite d\'un anneau maléfique et doit le détruire pour sauver la Terre du Milieu.',
      'https://example.com/posters/lotr.jpg',
    ),
    Movie(
      3,
      'Parasite',
      'Drame',
      2019,
      4.7,
      'Une famille pauvre s\'infiltre progressivement dans le foyer d\'une famille riche, avec des conséquences inattendues.',
      'https://example.com/posters/parasite.jpg',
    ),
    Movie(
      4,
      'Interstellar',
      'Science-Fiction',
      2014,
      4.6,
      'Un groupe d\'explorateurs voyage à travers un trou de ver dans l\'espace pour assurer la survie de l\'humanité.',
      'https://example.com/posters/interstellar.jpg',
    ),
    Movie(
      5,
      'La La Land',
      'Comédie musicale',
      2016,
      4.3,
      'Une actrice aspirante et un musicien de jazz tombent amoureux tout en poursuivant leurs rêves à Los Angeles.',
      'https://example.com/posters/lalaland.jpg',
    ),
    Movie(
      6,
      'Get Out',
      'Horreur',
      2017,
      4.4,
      'Un jeune homme rend visite à la famille de sa petite amie et découvre progressivement un terrible secret.',
      'https://example.com/posters/getout.jpg',
    ),
  ];

  //  ma fonction pour recuperer toute la liste de mes filmes
  List<Movie> getAll() => _maListe;

  // ma fonction qui retourne la liste de mes genres de film

  Set<String> get genres {
    return getAll().map((film) => film.genre).toSet();
  }

  // fonction pour retourner un film par son id

  Movie? getById(int id) {
    return _maListe.where((l) => l.id == id).firstOrNull;
  }
}
