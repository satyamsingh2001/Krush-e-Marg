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
    final brearToken = prefs.getString("barrierToken");
    final userid = prefs.getString("userId");
    final response = await http.get(Uri.parse('$orderHistoryUrl$userid'),
    headers: {
      'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $brearToken'
    },);
    var data = jsonDecode(response.body);
    if (data['status'] == 1) {

      var universalList = data['data'];
      for(int i =0;i<universalList.length;i++){
        List subList = universalList[i];

        for(int j=0;j<subList.length;j++){
          orderHistory.add(subList[j]);
          viewOrder = List.generate(orderHistory.length, (index) => 'View Order');
          // viewOrder.insert(0, 'Track Order');
          // print(data);

        }
      }
      // print(orderHistory.length);
      // print(orderHistory);
      // print(response.body);



      // orderHistory.value = data['data']['data'];

        update();
    } else {
      throw Exception('Failed to load history');
    }
  }
}