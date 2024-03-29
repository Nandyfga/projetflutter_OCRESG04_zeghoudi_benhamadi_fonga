import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/models/game.dart';

class SteamApi {
  static Future<List<String>> fetchMostPlayedGamesIds() async {
    final response = await http.get(Uri.parse(
        'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final gamesData = data['response']['ranks'];
      //print(response.body);

      if (gamesData != null) {
        final gamesIds = List<String>.from(
            gamesData.map((gameData) => gameData['appid'].toString()));

        return gamesIds;
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
      print(gameData);
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
        print(game);
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

  static Future<List<SteamGame>> fetchMostPlayedGames() async {
    final gamesIds = await fetchMostPlayedGamesIds();
    //print(fetchMostPlayedGamesIds);
    final games = <SteamGame>[];
    for (final id in gamesIds) {
      final game = await fetchGameDetails(id);
      //print(fetchGameDetails);
      if (game != null) {
        games.add(game);
      }
    }
    return games;
  }
}



/*Future<Game> fetchGameData() async {
  final response = await http.get(Uri.parse('https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/?'));
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return Game.fromJson(data);
  } else {
    throw Exception('Failed to fetch game data');
  }
}*/