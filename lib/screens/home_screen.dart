import 'package:flutter/material.dart';
import 'package:untitled1/models/game.dart';
import 'package:untitled1/blocs/api/api.dart';
import 'steam_game_details.dart';


class SteamGamesList extends StatelessWidget {
  final Future<List<SteamGame>> _futureGames = SteamApi.fetchMostPlayedGames();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Most played games on Steam'),
      ),
      body: FutureBuilder<List<SteamGame>>(
        future: _futureGames,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final games = snapshot.data!;
            return ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(game.imageUrl),
                    title: Text(game.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SteamGameDetails(game: game)),
                      );
                    },
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
        title: const Text('Accueil'),
      ),
      body: FutureBuilder<Game>(
        future: futureGame,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final game = snapshot.data!;
            if (game.response != null && game.response!.ranks != null) {
              return ListView.builder(
                itemCount: game.response!.ranks!.length,
                itemBuilder: (context, index) {
                  final rank = game.response!.ranks![index];
                  return ListTile(
                    leading: Image.network(rank.logoUrl!),
                    title: Text(rank.name!),
                    subtitle: Text('Position : ${rank.rank}'),
                  );
                },
              );
            } else {
              return Center(
                child: Text('Aucune donnée trouvée'),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur: ${snapshot.error}'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}*/






