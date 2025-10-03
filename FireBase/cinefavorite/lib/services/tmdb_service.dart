//meu serviço de conexão com a API

import 'dart:convert';

import 'package:http/http.dart' as http;

class TmdbService{
  //colocar os ddaos da api
  static const String _apiKey = "1fa5c2d59029fd1c438cc35713720604"; // static ñ é especido do objeto, mas da classe
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static const String _idioma = "pt-BR";
  //static -> atributos da classe e nn do obj

  //método para buscar filme com base no texto( static) -> metodo q vai ser executado pela classe e nn pelo obj
  static Future<List<Map<String, dynamic>>> searchMovies(String query) async{
    //convertrer string em url
    final apiUrl = Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$query&language=$_idioma');
    final  response = await http.get(apiUrl);

    //se resp for ok ==200
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data["results"]);
      }else{
        //caso de erro cria uma exeption
        throw Exception("Falha ao buscar filmes da API");
      }
  }

  //método de busca filme pelo ID
}