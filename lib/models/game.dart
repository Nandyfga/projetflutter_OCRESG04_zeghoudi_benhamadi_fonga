class Game {
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
}

/*class Game {
  Response? response;
  String? name;
  String? publishers;
  String? header_image;



  Game({this.response, this.publishers, this.header_image, this.name});

  Game.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    name = json['name'] as String?;
    publishers = json['name'] as String?;
    header_image = json['name'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    data['name'] = this.name;
    data['publishers'] = this.publishers;
    data['header_image'] = this.header_image;
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