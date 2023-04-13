import 'package:flutter/material.dart';
import 'package:untitled1/models/game.dart';
import 'like_screen.dart';
import 'wishlist_screen.dart';
import 'view_screen.dart';

class GameDetailsScreen extends StatelessWidget {
  final SteamGame game;

  const GameDetailsScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détail du jeu'),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(game.imageUrl),
            Card(
              color: Color(0xFF1A2025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
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
                            backgroundColor: Color(0xFF8860FC),
                            side: BorderSide(color: Colors.deepPurpleAccent),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewScreen(game: game),
                              ),
                            );
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
                            backgroundColor: Colors.transparent,
                            side: BorderSide(color: Colors.deepPurpleAccent),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      game.name,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5,

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      game.description,
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
      ),
    );
  }
}


