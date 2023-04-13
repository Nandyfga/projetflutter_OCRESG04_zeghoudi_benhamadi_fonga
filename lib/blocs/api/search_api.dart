import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/models/game.dart';

class SearchApi {
  static Future<List<String>> fetchMostPlayedGamesNames() async {
    final response = await http.get(Uri.parse(
        'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final gamesData = data['response']['ranks'];

      if (gamesData != null) {
        final gamesIds = List<String>.from(
            gamesData.map((gameData) => gameData['appid'].toString()));

        final games = await Future.wait(
            gamesIds.map((gameId) async {
              final gameDetails = await fetchGameDetails(gameId);
              return gameDetails.name;
            })
        );
        return games;
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load most played games');
    }
  }

  static Future<SteamGame> fetchGameDetails(String appId) async {
    final response = await http.get(Uri.parse(
        'https://store.steampowered.com/api/appdetails?appids=$appId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final gameData = data[appId]['data'];

      if (gameData != null && gameData['name'] != null) {
        final game = SteamGame(
          name: gameData['name'],
          appId: appId,
          imageUrl: gameData['header_image'] ?? '',
          shortDescription: gameData['short_description'] ?? '',
          publishers: gameData['publishers'] != null
              ? gameData['publishers'].join(', ')
              : '',
          price: gameData['is_free'] == true
              ? 'Free to play'
              : (gameData['price_overview'] != null
              ? gameData['price_overview']['final_formatted'] ?? ''
              : ''),
          description: gameData['detailed_description'] ?? '',
        );
        return game;
      }
    }
    return SteamGame(
      name: '',
      appId: '',
      imageUrl: '',
      shortDescription: '',
      publishers: '',
      price: '',
      description: '',
    );
  }

  static Future<List<SteamGame>> searchGame(String? gameName) async {
    //print(gameName);
    final response = await http.get(Uri.parse(
        'https://steamcommunity.com/actions/SearchApps/${Uri.encodeComponent(
            gameName.toString())}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<dynamic> results = List<dynamic>.from(data);
      //print(results);

      final games = await Future.wait(
          results.map((result) async {
            final gameDetails = await fetchGameDetails(
                result['appid'].toString());
            return gameDetails;
          })
      );
      //print(games);
      return games;
    } else {
      throw Exception('Failed to search game');
    }
  }
}