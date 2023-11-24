class TopTeams {
  int? id;
  int? ranking;
  String? name;
  String? logo;
  List<Players>? players;

  TopTeams({this.id, this.ranking, this.name, this.logo, this.players});

  TopTeams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ranking = json['ranking'];
    name = json['name'];
    logo = json['logo'];
    if (json['players'] != null) {
      players = <Players>[];
      json['players'].forEach((v) {
        players!.add(Players.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ranking'] = ranking;
    data['name'] = name;
    data['logo'] = logo;
    if (players != null) {
      data['players'] = players!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Players {
  String? fullname;
  String? image;
  String? nickname;
  Country? country;

  Players({this.fullname, this.image, this.nickname, this.country});

  Players.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    image = json['image'];
    nickname = json['nickname'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['image'] = image;
    data['nickname'] = nickname;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    return data;
  }
}

class Country {
  String? name;
  String? flag;

  Country({this.name, this.flag});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['flag'] = flag;
    return data;
  }
}
