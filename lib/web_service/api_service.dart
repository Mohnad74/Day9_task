import 'package:day9_task/model/tv_shows.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));

  Future<List<tv_show>> getTVShows(int pageNumber) async {
    try {
      final response = await _dio.get(
          'https://api.themoviedb.org/3/tv/airing_today?api_key=3f6ceca70c1e82eb45553017a27884cb&page=$pageNumber');
      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((tvShowsjson) => tv_show.fromJson(tvShowsjson))
            .toList();
      } else {
        throw Exception('Error  casting data');
      }
    } catch (e) {
      throw Exception('Error getting Data');
    }
  }

  Future<List<tv_show>> getRecommendations(int showid) async {
    try {
      final response = await _dio.get(
          'https://api.themoviedb.org/3/tv/$showid/recommendations?api_key=3f6ceca70c1e82eb45553017a27884cb');
      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((tvShowsjson) => tv_show.fromJson(tvShowsjson))
            .toList();
      } else {
        throw Exception('Error fetching seasons');
      }
    } catch (e) {
      throw Exception('Error getting TV show seasons');
    }
  }

  Future<List<dynamic>> getSeasons(int showid) async {
    try {
      final response = await _dio.get(
          'https://api.themoviedb.org/3/tv/$showid?api_key=3f6ceca70c1e82eb45553017a27884cb');
      if (response.statusCode == 200) {
        return response.data['seasons'] as List;
      } else {
        throw Exception('Error fetching seasons');
      }
    } catch (e) {
      throw Exception('Error getting TV show seasons');
    }
  }
}
