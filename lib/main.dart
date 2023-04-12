import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled1/blocs/auth/auth_bloc.dart';
import 'package:untitled1/screens/login_screen.dart';
import 'package:untitled1/screens/signup_screen.dart';
import 'package:untitled1/screens/home_screen.dart';
import 'package:untitled1/screens/search_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
//const primaryColor = Color(0xFF151026);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      /*
      theme: ThemeData(
        primaryColor: primaryColor,
      ),*/
      home: BlocProvider(
        create: (_) => AuthBloc(),
        child: LoginScreen(),
        //child: SearchScreen(),
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

/*import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled1/blocs/auth/auth_bloc.dart';
import 'package:untitled1/screens/login_screen.dart';
import 'package:untitled1/screens/signup_screen.dart';
import 'package:untitled1/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
//const primaryColor = Color(0xFF151026);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      /*
      theme: ThemeData(
        primaryColor: primaryColor,
      ),*/
      home: BlocProvider(
        create: (_) => AuthBloc(),
        child: LoginScreen(),
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/signup': (context) => SignupScreen(),
      },
    );
  }
}*/