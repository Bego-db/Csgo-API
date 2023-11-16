import 'dart:io';
import 'package:csgo/product/model/cs_model.dart';
import 'package:dio/dio.dart';

class MatchResultService {
  Future<List<MatchesResultModel>?> fetchMatchResults() async {
    final dio = Dio();
    final res = await dio.get("https://hltv-api.vercel.app/api/results.json");

    if (res.statusCode == HttpStatus.ok) {
      final jsonBody = res.data;
      if (jsonBody is List) {
        return jsonBody.map((e) => MatchesResultModel.fromJson(e)).toList();
      }
    } else {
      Exception("Hata");
    }
    return null;
  }
}
