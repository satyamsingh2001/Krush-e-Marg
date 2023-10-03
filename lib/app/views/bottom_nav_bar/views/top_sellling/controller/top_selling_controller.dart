import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../const/api_string.dart';

class TopSellingController extends GetxController {
  List topSellList = [].obs;

  Future<void> fetchTopSell() async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    // final id = prefs.getString("id");

    final response = await http.get(Uri.parse(topSellUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $brearToken',
    });

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      topSellList = data['data'];
      // print(data);
      // print(brearToken);
      // print("sssssssssssssssssssssssssssssssssssssss");
      update();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
