import 'package:flutter/material.dart';
import 'package:untitled1/models/game.dart';
import 'package:untitled1/blocs/api/api.dart';

class SteamGameDetails extends StatelessWidget {
  final SteamGame game;

  const SteamGameDetails({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
      ),
      body: FutureBuilder<SteamGame>(
        future: SteamApi.fetchGame(game.appId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final game = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(game.imageUrl),
                  SizedBox(height: 16.0),
                  Text(game.name, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16.0),
                  Text('App ID: ${game.appId}', style: TextStyle(fontSize: 18.0)),
                ],
              ),
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