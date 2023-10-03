import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../const/api_string.dart';

class RecPController extends GetxController {
  List recProduct = [].obs;

  Future<void> fetchRecP() async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    // final id = prefs.getString("id");

    final response = await http.get(Uri.parse(recommendedUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $brearToken',
    });

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      recProduct = data['data'];
      // print(data);
      // print(brearToken);
      // print("sssssssssssssssssssssssssssssssssssssss");
      update();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
