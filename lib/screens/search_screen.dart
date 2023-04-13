import 'package:flutter/material.dart';
import 'package:untitled1/models/game.dart';
//import 'package:untitled1/blocs/api/search_api.dart';

import 'steam_game_details.dart';

class SearchScreen extends StatelessWidget {
  final List<SteamGame> games;

  SearchScreen({required this.games});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un jeu...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Nombre de résultats: ${games.length}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                SteamGame game = games[index];
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
//import 'package:untitled1/blocs/api/search_api.dart';

import 'steam_game_details.dart';

class SearchScreen extends StatefulWidget {
  final List<SteamGame> games;
  final String searchQuery;

  //SearchScreen({required this.games});
  const SearchScreen({Key? key, required this.games, required this.searchQuery}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SteamGame> _searchResults = [];

  void _performSearch(String query) {
    List<SteamGame> results = [];
    for (SteamGame game in widget.games) {
      if (game.name.toLowerCase().contains(query.toLowerCase())) {
        results.add(game);
      }
    }
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'Rechercher un jeu...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Nombre de résultats: ${_searchResults.length}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                SteamGame game = _searchResults[index];
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
              },
            ),
          ),
        ],
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:untitled1/models/game.dart';
import 'package:untitled1/blocs/api/search_api.dart';

import 'steam_game_details.dart';

class SearchScreen extends StatefulWidget {
  final List<SteamGame> games;

  const SearchScreen({Key? key, required this.games}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SteamGame> games = [];


  void _handleSearch(String query) async {
    List<SteamGame> searchResults = await SearchApi.searchGame(query);
    setState(() {
      games = searchResults;
    });
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
        title: Text('Recherche'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un jeu...',
                border: OutlineInputBorder(),
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),
              maxLength: 30,
              onSubmitted: _handleSearch,
              controller: _searchController,
            ),
          ),
          games == null
              ? Container()
              : Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Nombre de résultats: ${games.length}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Expanded(
            child: games == null
                ? Container()
                : ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                SteamGame game = games[index];
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
      ),
    );
  }
}
*/


