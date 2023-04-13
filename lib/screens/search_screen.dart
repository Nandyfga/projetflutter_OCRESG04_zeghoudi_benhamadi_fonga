import 'package:flutter/material.dart';
import 'package:untitled1/models/game.dart';
import 'package:untitled1/blocs/api/api.dart';

//import 'steam_game_details.dart';

class SearchScreen extends StatefulWidget {
  const  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<SteamGame>> _futureGames;

  //late SteamGame _mostPlayedGame;

  @override
  void initState() {
    super.initState();
    _futureGames = SteamApi.fetchMostPlayedGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Recherche
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un jeu...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),
            ),
          ),
          Expanded( // Wrap the ListView with Expanded widget
            child: FutureBuilder<List<SteamGame>>(
              future: _futureGames,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final games = snapshot.data!;
                  return ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      final game = games[index];
                      return Container(width: 400, height: 120,
                        child: Card(
                        child: ListTile(
                          leading: Image.network(game.imageUrl),
                          title: Text(game.name),
                        ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}