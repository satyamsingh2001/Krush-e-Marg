import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../../const/api_string.dart';

class OrderApiController extends GetxController{
  List<String> viewOrder=[];
  RxList orderHistory = [].obs;
  Future<void> fetchOrderList() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.get(Uri.parse('$orderHistoryUrl+$userid'));

    var data = jsonDecode(response.body);
    if (data['status'] == 1) {
        orderHistory.value = data['data']['data'];
        viewOrder = List.generate(orderHistory.length, (index) => 'View Order');
        viewOrder.insert(0, 'Track Order');
        update();
    } else {
      throw Exception('Failed to load history');
    }
  }
}