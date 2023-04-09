import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/models/game.dart';

class SteamApi {
  static Future<List<SteamGame>> fetchMostPlayedGames() async {
    final response = await http.get(Uri.parse('https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final gamesData = data['response']['games'] as List;
      final games = gamesData.map((gameData) => SteamGame.fromJson(gameData)).toList();

      return games;
    } else {
      throw Exception('Failed to load most played games');
    }
  }

  static Future<SteamGame> fetchGame(String appId) async {
    final response = await http.get(Uri.parse('https://store.steampowered.com/api/appdetails?appids=$appId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final gameData = data[appId]['data'];
      final game = SteamGame.fromJson({
        'name': gameData['name'],
        'appid': appId,
        'img_logo_url': gameData['header_image'],
      });

      return game;
    } else {
      throw Exception('Failed to load game with ID $appId');
    }
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