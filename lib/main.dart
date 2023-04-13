import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled1/blocs/auth/auth_bloc.dart';
import 'package:untitled1/screens/login_screen.dart';
import 'package:untitled1/screens/signup_screen.dart';
import 'package:untitled1/screens/home_screen.dart';
import 'package:untitled1/screens/like_screen.dart';
import 'package:untitled1/screens/wishlist_screen.dart';
//import 'package:untitled1/screens/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

const primaryColor = Color(0xFF151026);
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: BlocProvider(
        create: (_) => AuthBloc(),
        child: LoginScreen(),
        //child: HomeScreen(),
      ),
      routes: {
        //'/home': (context) => SteamGamesList(),
        '/home': (context) => HomeScreen(),
        '/signup': (context) => SignupScreen(),
      },
    );
  }
}

/*void main() async {
  try {
    final gamesIds = await SteamApi.fetchMostPlayedGamesIds();
    //print(gamesIds);
    final games = await Future.wait(gamesIds.map((appId) => SteamApi.fetchGameDetails(appId)));
    for (final game in games) {
      print('Name: ${game.name}');
      print('App ID: ${game.appId}');
      print('Short Description: ${game.shortDescription}');
      print('Image URL: ${game.imageUrl}');
      print('-----------------------------------');
    }
  } catch (e) {
    print(e);
  }
}
*/

/*import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:untitled1/models/game.dart';

class SteamApi {
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
    print(gameName);
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

void main() async {
  stdout.write('Enter the name of the game you want to search: ');
  final input = stdin.readLineSync();
  //print(input);
  final games = await SteamApi.searchGame(input);
  games.forEach((game) {
    print('Name: ${game.name}');
    print('App ID: ${game.publishers}');
 // print(games);
  });
}
*/



/* void main() async {

  final mostPlayedGamesIds = await SteamApi.fetchMostPlayedGamesIds();
  print(mostPlayedGamesIds);

  for (var i = 0; i < mostPlayedGamesIds.length; i++) {
    final appId = mostPlayedGamesIds[i];
    final game = await SteamApi.fetchGames(appId);
    print('${i+1}. ${game.name} (AppID: ${game.appId})');
    print('    Description: ${game.shortDescription}');
   // print('    Metacritic Score: ${game.metacriticScore ?? 'N/A'}');
   // print('    Release Date: ${game.releaseDate?.toIso8601String() ?? 'TBA'}');
    print('    Image URL: ${game.imageUrl}');
    print('');
  }
}


static Future<SteamGame> fetchGame(String appId) async {
    final response = await http.get(Uri.parse('https://store.steampowered.com/api/appdetails?appids=$appId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final gameData = data[appId]['data'];
      final game = SteamGame.fromJson({
        'name': gameData['name'],
        'appId': appId,
        'shortDescription': gameData['short_description'] ?? '',
        'metacriticScore': gameData['metacritic'] != null ? gameData['metacritic']['score'] : null,
        'releaseDate': gameData['release_date']['date'] != null ? DateTime.parse(gameData['release_date']['date']) : null,
        'imageUrl': gameData['header_image'],
      });
      return game;
    } else {
      throw Exception('Failed to load game with ID $appId');
    }
  }
}

void main() async {
  final mostPlayedGamesIds = await SteamApi.fetchMostPlayedGamesIds();
  //print(mostPlayedGamesIds);
  final gameList = await SteamApi.fetchGames(mostPlayedGamesIds);
  print(gameList);

  for (final game in gameList) {
    print('Name: ${game.name}');
    print('App ID: ${game.appId}');
    print('Short description: ${game.shortDescription}');
    print('Image URL: ${game.imageUrl}');
    print('');
  }
}

*/
