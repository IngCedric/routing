class Movie {
  final int id;
  final String titre;
  final String genre;
  final int? annee;
  final double note;
  final String synopsis;
  final String posterUrl;

  Movie(
    this.id,
    this.titre,
    this.genre,
    this.annee,
    this.note,
    this.synopsis,
    this.posterUrl,
  );
}
