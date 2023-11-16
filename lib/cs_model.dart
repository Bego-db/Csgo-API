class MachModel {
  Event? event;
  String? maps;
  String? time;
  List<Teams>? teams;
  int? matchId;

  MachModel({this.event, this.maps, this.time, this.teams, this.matchId});

  MachModel.fromJson(Map<String, dynamic> json) {
    event = json['event'] != null ? Event.fromJson(json['event']) : null;
    maps = json['maps'];
    time = json['time'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(Teams.fromJson(v));
      });
    }
    matchId = json['matchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (event != null) {
      data['event'] = event!.toJson();
    }
    data['maps'] = maps;
    data['time'] = time;
    if (teams != null) {
      data['teams'] = teams!.map((v) => v.toJson()).toList();
    }
    data['matchId'] = matchId;
    return data;
  }
}

class Event {
  String? name;
  String? logo;

  Event({this.name, this.logo});

  Event.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['logo'] = logo;
    return data;
  }
}

class Teams {
  String? name;
  String? logo;
  int? result;

  Teams({this.name, this.logo, this.result});

  Teams.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['logo'] = logo;
    data['result'] = result;
    return data;
  }
}
