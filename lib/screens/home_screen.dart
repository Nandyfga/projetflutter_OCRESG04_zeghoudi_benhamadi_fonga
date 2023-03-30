import 'package:flutter/material.dart';
import 'package:untitled1/models/game.dart';
import 'package:untitled1/widgets/game_list.dart';
import 'package:untitled1/blocs/api/api.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
  //_HomeScreenState createState() => _HomeScreenState();
}

//class _HomeScreenState extends State<HomeScreen> {
//List<Game>? _games;

class _HomePageState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Game>? _games;
  //final searchBloc = SearchBloc();


  @override
  void initState() {
    super.initState();
    _fetchGames();
  }

  void _fetchGames() async {
    try {
      final games = await fetchGames();
      setState(() {
        _games = games;
      });
    } catch (e) {
      print(e);
      // handle the error here
    }
  }
/*void _fetchGames() async {
    final games = await fetchGames();
    setState(() {
      _games = games;
    });
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Rechercher',
                ),
              ),
              if (_games != null)
                Column(
                  children: [
                    Image.network(_games!.first.iconUrl),
                    const SizedBox(height: 16),
                    const Text('Jeux les plus joués :'),
                    const SizedBox(height: 8),
                    Expanded(
                      child: GamesList(games: _games!),
                    ),
                  ],
                )
              else
                const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}





/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

import 'package:untitled1/blocs/search_bloc.dart';
import 'package:untitled1/blocs/image_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late DatabaseReference _imageRef;

  _HomePageState() {
    // Initialize the Firebase database reference
    _imageRef = FirebaseDatabase.instance.reference().child('image');
  }

  @override
  void initState() {
    super.initState();

    // On se connecte à la base de données Firebase
    _imageRef = FirebaseDatabase.instance.reference().child('image');
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
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // On envoie l'événement de recherche au Bloc
                    BlocProvider.of<SearchBloc>(context)
                        .add(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, List<String>>(
              builder: (context, state) {
                if (state.isEmpty) {
                  return Center(
                    child: Text('No results'),
                  );
                }

                return ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state[index]),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16),
          BlocBuilder<ImageBloc, String>(
            builder: (context, state) {
              if (state.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Image.network(
                'https://cdn.akamai.steamstatic.com/steam/apps/${state}/logo.png',
                height: 200,
              );
            },
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:untitled1/blocs/api/steam_api_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Steam App'),
      ),
      body: BlocBuilder<SteamBloc, SteamState>(
        builder: (context, state) {
          if (state is SteamLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SteamLoaded) {
            return Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                  ),
                  onSubmitted: (query) {
                    BlocProvider.of<SteamBloc>(context)
                        .add(SteamSearchEvent(searchQuery: query));
                  },
                ),
                Image.network(
                  state.data['applist']['apps'][0]['img_icon_url'],
                ),
              ],
            );
          } else if (state is SteamError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

*/




