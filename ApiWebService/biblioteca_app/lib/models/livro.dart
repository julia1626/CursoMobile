class Livro {
  // atributos
  final String? id; // pode ser nulo inicialmente -> id será atribuído pelo BD
  final String titulo;
  final String autor;
  bool disponivel;

  // construtor
  Livro({ this.id, required this.titulo, required this.autor, this.disponivel = true,});

  // métodos
  // toJson
  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "autor": autor,
        "disponivel": disponivel,
      };

  // fromJson
  factory Livro.fromJson(Map<String, dynamic> json) => Livro(
        id: json["id"]?.toString(),
        titulo: json["titulo"].toString(),
        autor: json["autor"].toString(),
        disponivel: json["disponivel"] ?? true,
      );
}
