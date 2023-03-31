import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/models/game.dart';


Future<Game> fetchGameData() async {
  final response = await http.get(Uri.parse('https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/?'));
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return Game.fromJson(data);
  } else {
    throw Exception('Failed to fetch game data');
  }
}



/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/models/game.dart';

Future<List<Game>> fetchGameData() async {
  final mostPlayedUrl = Uri.parse('https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/?');
  final mostPlayedResponse = await http.get(mostPlayedUrl);
  if (mostPlayedResponse.statusCode == 200) {
    final List<dynamic> mostPlayedGames = json.decode(mostPlayedResponse.body)['response']['games'];
    final List<Game> games = [];

    for (final game in mostPlayedGames) {
      final appId = game['appid'];
      final appDetailsUrl = Uri.parse('https://store.steampowered.com/api/appdetails?appids=$appId');
      final appDetailsResponse = await http.get(appDetailsUrl);
      if (appDetailsResponse.statusCode == 200) {
        final appDetails = json.decode(appDetailsResponse.body)[appId.toString()]['data'];
        games.add(Game.fromJson(appDetails));
      } else {
        throw Exception('Failed to fetch game data for appID: $appId');
      }
    }
    return games;
  } else {
    throw Exception('Failed to fetch most played games data');
  }
}*/