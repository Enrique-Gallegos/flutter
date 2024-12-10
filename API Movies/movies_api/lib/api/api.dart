import 'package:movies_api/models/movie.dart';
import 'package:movies_api/widgets/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static const _trendingUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apikey}';

  static const _topratedUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apikey}';
  static const _upcomingUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apikey}';

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final results = decodedData['results'] as List<dynamic>;
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Algo salió mal.');
    }
  }

  Future<List<Movie>> getTopRated() async {
    final response = await http.get(Uri.parse(_topratedUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final results = decodedData['results'] as List<dynamic>;
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Algo salió mal.');
    }
  }

  Future<List<Movie>> getUpcoming() async {
    final response = await http.get(Uri.parse(_upcomingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final results = decodedData['results'] as List<dynamic>;
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Algo salió mal.');
    }
  }

  Future<String?> getMovieTrailer(int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=${Constants.apikey}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final results = decodedData['results'] as List<dynamic>;

      final trailer = results.firstWhere(
        (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
        orElse: () => null,
      );

      if (trailer != null) {
        return 'https://www.youtube.com/watch?v=${trailer['key']}';
      }
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getMovieCast(int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=${Constants.apikey}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final cast = decodedData['cast'] as List<dynamic>;

      return cast.take(10).map((actor) {
        return {
          'name': actor['name'] ?? 'Unknown',
          'profilePath': actor['profile_path'],
        };
      }).toList();
    } else {
      throw Exception('Error al obtener el reparto.');
    }
  }
}
