import 'package:flutter/material.dart';
import 'package:untitled1/models/game.dart';
import 'package:untitled1/blocs/api/api.dart';
import 'package:untitled1/blocs/api/search_api.dart';
import 'package:untitled1/screens/like_screen.dart';
import 'package:untitled1/screens/wishlist_screen.dart';

import 'search_screen.dart';
import 'steam_game_details.dart';

class HomeScreen extends StatefulWidget {
  const  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<SteamGame>> _futureGames;

  final _searchController = TextEditingController();

  void _handleSearch(String query) async {
    List<SteamGame> games = await SearchApi.searchGame(query);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchScreen(games: games), // Ajout du paramètre searchQuery
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    _futureGames = SteamApi.fetchMostPlayedGames();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        backgroundColor: Color(0xFF1A2025),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MesLikes(),
                    ),
                  );
                },
                icon: Icon(Icons.favorite_border),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Wishlist(),
                    ),
                  );
                },
                icon: Icon(Icons.star_border),
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Color(0xFF1A2025),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recherche
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              onSubmitted: _handleSearch,
              decoration: InputDecoration(
                hintText: 'Rechercher un jeu...', hintStyle: TextStyle(color:Colors.white),
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
                                style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.normal, decoration: TextDecoration.underline),
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
                            color: Color(0xFF1A2025),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                              leading: Image.network(game.imageUrl),
                              title: Text(game.name, style: TextStyle(
                                color: Colors.white,
                              ),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(game.publishers, style: TextStyle(
                                    color: Colors.white,
                                  ),),
                                  SizedBox(height: 5),
                                  Text(game.price, style: TextStyle(
                                    color: Colors.white,
                                  ),),
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





