import 'package:flutter/material.dart';
import 'package:untitled1/models/game.dart';
import 'package:untitled1/blocs/api/api.dart';

//import 'steam_game_details.dart';

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Recherche
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un jeu',
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
                      if (index == 0) {
                        return SizedBox(width: 400, height: 200,
                          child: Card(
                            child: Ink.image(
                            image: NetworkImage(game.imageUrl),
                            fit: BoxFit.cover,
                            child: ListTile(
                              //leading: Image.network(game.imageUrl),
                              title: Text(game.name),
                      //subtitle: Text('${game.publishers} • ${game.price}'),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(width: 400, height: 120,
                          child: Card(
                            child: ListTile(
                              leading: Image.network(game.imageUrl),
                              title: Text(game.name),
                              //subtitle: Text('${game.publishers} • ${game.price}'),
                            ),
                          ),
                        );
                      }
                    }
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




/*class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  late Future<Game> futureGame;

  @override
  void initState() {
    super.initState();
    futureGame = fetchGameData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body:FutureBuilder<Game>(
        future: futureGame,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.response!.ranks!.length,
              itemBuilder: (context, index) {
                final rank = snapshot.data!.response!.ranks![index];
                return ListTile(
                  title: Text('Rank ${rank.rank}'),
                  subtitle: Text('AppID: ${rank.appid}, Peak in game: ${rank.peakInGame}}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Container();
        },
      ),
    );
  }
}*/

/*@override
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
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un jeu',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // Jeu le plus joué
          FutureBuilder<List<SteamGame>>(
            future: _futureGames,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final games = snapshot.data!;
                _mostPlayedGame = games.first;
                return Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Le jeu le plus joué',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GameDetailsPage(game: _mostPlayedGame),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Image.network(_mostPlayedGame.imageUrl),
                              SizedBox(height: 16.0),
                              Text(
                                _mostPlayedGame.name,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Expanded(
                flex: 2,
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          // Liste de jeux
          Expanded(
            flex: 3,
            child: FutureBuilder<List<SteamGame>>(
              future: _futureGames,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final games = snapshot.data!;
                  return ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      final game = games[index];
                      return ListTile(
                        leading: Image.network(game.imageUrl),
                        title: Text(game.name),
                        subtitle: Text('${game.publishers} • ${game.price}'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GameDetailsPage(game: game),
                              ),
                            );
                          },
                          child: Text('En savoir plus'),
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

*/






