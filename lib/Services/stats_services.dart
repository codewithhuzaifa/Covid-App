import 'dart:convert';

import 'package:covidapp/Models/worldstatmodels.dart';
import 'package:covidapp/Services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatServices {
  Future<WorldStatsModel> getworldstats() async {
    final response = await http.get(Uri.parse(AppUrl.worldstatsapi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Some Error Occured');
    }
  }
}
