import 'package:flutter/material.dart';
import 'package:untitled1/models/game.dart';

class GameDetailsPage extends StatelessWidget {
  final SteamGame game;

  const GameDetailsPage({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détail du jeu'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(game.imageUrl),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.network(game.imageUrl),
                      SizedBox(height: 16.0),
                      Text(
                        game.name,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        game.publishers,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        game.description,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
