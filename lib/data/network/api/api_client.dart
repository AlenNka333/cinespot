import 'dart:convert';
import 'package:cinespot/utils/constants.dart';
import 'package:cinespot/data/network/models/movie.dart';
import 'package:cinespot/data/network/models/user.dart';
import 'package:cinespot/data/network/models/video.dart';
import 'package:http/http.dart' as http;

class APIClient {
  static final APIClient _apiClient = APIClient._internal();

  final Map<String, String> headers = {
    "accept": "application/json",
    "content-type": "application/json",
    "Authorization": "Bearer ${AppConstants.apiKey}"
  };

  factory APIClient() {
    return _apiClient;
  }

  APIClient._internal();

  Future<String?> createRequestToken() async {
    final Uri url =
        Uri.parse("${AppConstants.baseUrl}authentication/token/new");
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['request_token'];
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (error) {
      print("Request failed: $error");
      return null;
    }
  }

  Future<String?> validateLogin(
      {required String username,
      required String password,
      required String token}) async {
    final Uri url = Uri.parse(
        "${AppConstants.baseUrl}authentication/token/validate_with_login");

    final body = jsonEncode(
        {"username": username, "password": password, "request_token": token});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['request_token'];
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (error) {
      print("Request failed: $error");
      return null;
    }
  }

  Future<String?> createSession({required String requestToken}) async {
    final Uri url =
        Uri.parse("${AppConstants.baseUrl}authentication/session/new");

    final body = json.encode({"request_token": requestToken});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['session_id'];
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (error) {
      print("Request failed: $error");
      return null;
    }
  }

  Future<User?> getAccountInfo({required String sessionId}) async {
    final Uri url =
        Uri.parse("${AppConstants.baseUrl}account?session_id=$sessionId");

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final User data = User.fromJson(jsonResponse);
        return data;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (error) {
      print("Request failed: $error");
      return null;
    }
  }

  Future<List<Movie>> getMovies(
      {required String category, required int page}) async {
    Uri url = Uri.parse("${AppConstants.baseUrl}movie/$category");
    final Map<String, String> queryParams = {'page': '$page'};

    url = url.replace(queryParameters: queryParams);

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<Movie> data = Movie.listFromJson(jsonResponse['results']);
        return data;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (error) {
      print("Request failed: $error");
      return [];
    }
  }

  Future<Movie?> fetchMovie({required String id}) async {
    Uri url = Uri.parse("${AppConstants.baseUrl}movie/$id");

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final Movie data = Movie.fromJson(jsonResponse);
        return data;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (error) {
      print("Request failed: $error");
      return null;
    }
  }

  Future<List<Video>> fetchMovieVideo({required String movieId}) async {
    Uri url = Uri.parse("${AppConstants.baseUrl}movie/$movieId/videos");

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<Video> data = Video.listFromJson(jsonResponse['results']);
        return data;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (error) {
      print("Request failed: $error");
      return [];
    }
  }

  Future<List<Movie>> fetchFavouriteMovies(
      {required String page, required int accountId}) async {
    Uri url =
        Uri.parse("${AppConstants.baseUrl}account/$accountId/favorite/movies");
    final Map<String, String> queryParams = {'page': '1'};

    url = url.replace(queryParameters: queryParams);

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<Movie> data = Movie.listFromJson(jsonResponse['results']);

        return data;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (error) {
      print("Request failed: $error");
      return [];
    }
  }

  Future<bool> addToFavourites(
      {required int accountId, required int movieId}) async {
    Uri url = Uri.parse("${AppConstants.baseUrl}account/$accountId/favorite");
    final body = json.encode({
      "media_type": "movie",
      "media_id": movieId,
      "favorite": true,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (error) {
      print("Request failed: $error");
      return false;
    }
  }

  Future<bool> removeFromFavourites(
      {required int accountId, required int movieId}) async {
    Uri url = Uri.parse("${AppConstants.baseUrl}account/$accountId/favorite");
    final body = json.encode({
      "media_type": "movie",
      "media_id": movieId,
      "favorite": false,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (error) {
      print("Request failed: $error");
      return false;
    }
  }

  Future<List<Movie>> fetchMoviesBy(
      {required String query, required String? year}) async {
    Uri url = Uri.parse(
        "${AppConstants.baseUrl}search/movie?query=$query${year != null ? "&year=$year" : ""}");

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<Movie> data = Movie.listFromJson(jsonResponse['results']);

        return data;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (error) {
      print("Request failed: $error");
      return [];
    }
  }

  Future<List<Movie>> fetchMoviesByYear({required String year}) async {
    Uri url = Uri.parse(
        "${AppConstants.baseUrl}/discover/movie?primary_release_year=$year");

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<Movie> data = Movie.listFromJson(jsonResponse['results']);

        return data;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (error) {
      print("Request failed: $error");
      return [];
    }
  }
}
