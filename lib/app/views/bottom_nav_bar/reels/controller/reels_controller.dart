import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../const/api_string.dart';

class ReelsController extends GetxController {
  // List reelsList = [];
  List<Map<String, dynamic>> reelsList = [];

  Future<void> fetchReels() async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    // final id = prefs.getString("id");

    final response = await http.get(Uri.parse(reelsUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $brearToken',
    });

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // reelsList = data;
      for (int i = 0; i < data.length; i++) {
        List story = data[i]['story'];
        for (int j = 0; j < story.length; j++) {
          if (data[i]['story'] != null) {
            reelsList.add(story[j]);
          }
        }
        // print(data);
        // print(reelsList);
        // print(brearToken);
        // print("sssssssssssssssssssssssssssssssssssssss");
        update();
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
