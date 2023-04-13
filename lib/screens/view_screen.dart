import 'package:flutter/material.dart';
import 'package:untitled1/models/game.dart';
import 'steam_game_details.dart';
import 'like_screen.dart';
import 'wishlist_screen.dart';

class ViewScreen extends StatelessWidget {
  final SteamGame game;

  const ViewScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détail du jeu'),
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
                icon: Icon(Icons.favorite),
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
                icon: Icon(Icons.star,
              ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         Image.network(game.imageUrl),
          Card(
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GameDetailsScreen(game: game),
                                ),
                              );
                            },
                            child: Text('DESCRIPTION'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(0),
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              side: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            child: Text('AVIS'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding:const EdgeInsets.all(16.0),
                    child: Text(
                      game.name,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5,
                    ),
                  ),
                    Padding(padding:const EdgeInsets.all(16.0),
                    child: Text(
                      game.shortDescription,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1,
                    ),
                    ),
                  ],
            ),
          ),
        ],
      ),
    );
  }
}