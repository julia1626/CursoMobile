//gerencia o relacionamento do modelo com o fireStore (firebase)

import 'dart:io';

import 'package:cine_favorite/models/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MovieFirestoreController {
  //atributos
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  //método para pegar o usuário logado
  User? get currentUser => _auth.currentUser;

  //método para pegar os filmes da coleção de favoritos
  //Stream => criar um ouvinte(listener => pegar a lista de favoritos sempre que for chamado)
  Stream<List<Movie>> getFavoriteMovies() {
    if (currentUser == null) return Stream.value([]);

    return _db
        .collection("usuarios")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Movie.fromMap(doc.data())).toList(),
        );
    //retorna a coleção que estava em json => convertida para obj de uma lista de filmes
  }

  //adicionar um filme a lista de favoritos
  void addFavoriteMovie(Map<String, dynamic> movieData) async {
    if (movieData["poster_path"] == null) return;

    //baixando a imagem da internet
    final imageUrl =
        "https://image.tmdb.org/t/p/w500${movieData["poster_path"]}";
    final responseImg = await http.get(Uri.parse(imageUrl));

    //armazenar a imagem no diretório do aplicativo
    final imgDir = await getApplicationDocumentsDirectory();
    //baixando a imagem para o aplicativo
    final file = File("${imgDir.path}/${movieData["id"]}.jpg");
    await file.writeAsBytes(responseImg.bodyBytes);

    //criar o OBJ do filme
    final movie = Movie(
      id: movieData["id"],
      title: movieData["title"],
      posterPath: file.toString(),
    );

    //adicionar o filme no firestore
    await _db
        .collection("usuarios")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(movie.id.toString())
        .set(movie.toMap());
  }

  //delete

  //update (modificar a nota)
  
}
