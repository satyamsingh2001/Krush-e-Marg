import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../const/api_string.dart';
import '../../../../controller/api_controller.dart';


class UpdateLSController extends GetxController{

  final CommunityController communityController = Get.find();

  Future<void> updateLikeShare(
       commId,activity,action,userId
      ) async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    final id = prefs.getString("userId");

    final response = await http.get(Uri.parse("$commUrl$commId/$activity/$action/$id"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $brearToken',
    });

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      communityController.fetchComm();
      update();
    } else {

      throw Exception('Failed to load ');
    }
  }
}

