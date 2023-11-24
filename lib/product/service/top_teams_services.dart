import 'dart:io';

import 'package:csgo/product/model/top_teams_model.dart';
import 'package:dio/dio.dart';

class TopTeamsServices {
   final dio = Dio();

   Future<List<TopTeams>?> getTopTeams() async {
     final res = await dio.get("https://hltv-api.vercel.app/api/player.json");
     if (res.statusCode == HttpStatus.ok) {
       final jsonBody= res.data;
       if (jsonBody is List) {
          return jsonBody.map((e) => TopTeams.fromJson(e)).toList();
       }
     }
     else{
      Exception("Hata");
     }
     return null;
   }
}