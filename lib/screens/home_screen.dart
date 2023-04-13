import 'package:flutter/material.dart';
import 'package:untitled1/models/game.dart';
import 'package:untitled1/blocs/api/api.dart';

import 'steam_game_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<SteamGame>> _futureGames;

  @override
  void initState() {
    super.initState();
    _futureGames = SteamApi.fetchMostPlayedGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
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
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<SteamGame>>(
              future: _futureGames,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final games = snapshot.data!;
                  return Stack(
                    children: [
                      // Image card
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Card(
                          child: Ink.image(
                            image: NetworkImage(games[0].imageUrl),
                            fit: BoxFit.cover,
                            child: ListTile(
                              title: Text(games[0].name,
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      // List of games
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.3,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ListView.builder(
                          itemCount: games.length,
                          itemBuilder: (context, index) {
                            final game = games[index];
                            return Container(
                              width: 400,
                              height: 120,
                              child: Card(
                                child: ListTile(
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                                  leading: Image.network(game.imageUrl),
                                  title: Text(game.name),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(game.publishers),
                                      SizedBox(height: 5),
                                      Text(game.price),
                                    ],
                                  ),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GameDetailsScreen(game: game),
                                        ),
                                      );
                                    },
                                    child: Text('En savoir plus'),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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




/*import 'package:flutter/material.dart';
import 'package:untitled1/models/game.dart';
import 'package:untitled1/blocs/api/api.dart';

import 'steam_game_details.dart';

class HomeScreen extends StatefulWidget {
  const  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        title: Text('Accueil'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
          Expanded(
            child: FutureBuilder<List<SteamGame>>(
              future: _futureGames,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final games = snapshot.data!;
                  return ListView.builder(
                    itemCount: games.length + 1, // add 1 for the "Les meilleures ventes" widget
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 600,
                              height: 200,
                              child: Card(
                                child: Ink.image(
                                  image: NetworkImage(games[index].imageUrl),
                                  fit: BoxFit.cover,
                                  child: ListTile(
                                    title: Text(games[index].name, style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                              child: Text(
                                'Les meilleures ventes',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        );
                      } else {
                        final game = games[index - 1]; // subtract 1 to account for the "Les meilleures ventes" widget
                        return Container(
                          width: 400,
                          height: 120,
                          child: Card(
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                              leading: Image.network(game.imageUrl),
                              title: Text(game.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(game.publishers),
                                  SizedBox(height: 5),
                                  Text(game.price),
                                ],
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GameDetailsScreen(game: game),
                                    ),
                                  );
                                },
                                child: Text('En savoir plus'),
                              ),
                            ),
                          ),
                        );
                      }
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
*/






