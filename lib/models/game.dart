class SteamGame {
  final String name;
  final String appId;
  final String imageUrl;
  final String shortDescription;
  final String publishers;
  final String price;
  final String description;

  SteamGame({required this.name, required this.appId, required this.imageUrl, required this.shortDescription, required this.publishers,
    required this.price, required this.description});
    //required this.publishers required this.price, required this.description

  factory SteamGame.fromJson(Map<String, dynamic> json) {
    final gameData = json['data'];

    return SteamGame(
      name: gameData['name'] ?? '',
      appId: json['appid'].toString(),
      imageUrl: gameData['header_image'] ?? '',
      shortDescription: gameData['short_description'] ?? '',
      publishers: gameData['publishers'] != null ? gameData['publishers'].join(', ') : '',
      price: gameData['is_free'] == true
          ? 'Free to play'
          : gameData['price_overview'] != null && gameData['price_overview']['final_formatted'] != null
          ? gameData['price_overview']['final_formatted']
          : '',
      description: gameData['detailed_description'] ?? '',
    );
  }
}

/**/

/*class Game {
  Response? response;

  Game({this.response});

  Game.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  int? rollupDate;
  List<Ranks>? ranks;

  Response({this.rollupDate, this.ranks});

  Response.fromJson(Map<String, dynamic> json) {
    rollupDate = json['rollup_date'];
    if (json['ranks'] != null) {
      ranks = <Ranks>[];
      json['ranks'].forEach((v) {
        ranks!.add(new Ranks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rollup_date'] = this.rollupDate;
    if (this.ranks != null) {
      data['ranks'] = this.ranks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ranks {
  int? rank;
  int? appid;
  int? lastWeekRank;
  int? peakInGame;

  Ranks({this.rank, this.appid, this.lastWeekRank, this.peakInGame});

  Ranks.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    appid = json['appid'];
    lastWeekRank = json['last_week_rank'];
    peakInGame = json['peak_in_game'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rank'] = this.rank;
    data['appid'] = this.appid;
    data['last_week_rank'] = this.lastWeekRank;
    data['peak_in_game'] = this.peakInGame;
    return data;
  }
}*/

/*class Game {
  final int? appId;
  final String? name;
  final String? imageUrl;
  final int? players;

  Game({required this.appId, required this.name, required this.imageUrl, required this.players});

  factory Game.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return Game(
      appId: data['steam_appid'],
      name: data['name'],
      imageUrl: data['header_image'] ?? '',
      players: json['players'],
    );
  }
}*/


