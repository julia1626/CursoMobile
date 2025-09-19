//classe de modelagem do obj movie
//reeceber os dados da API -> enviar os dados para FireStore

class Movie {
  //atributos
  final int id;
  final String title;
  final String posterPath;
  double rating; //nota que o usuáridará ao filme 0 a 5

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.rating = 0.0,
  });

  //métodos de conversão de obj <=> JSON
  //toMap OBJ => JSON
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "postarPath": posterPath,
      "rating": rating,
    };
  }

  //fromMap JSON => OBJ
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map["id"],
      title: map["title"],
      posterPath: map["posterPath"],
      rating: (map["rating"] as num).toDouble());
  }
}
