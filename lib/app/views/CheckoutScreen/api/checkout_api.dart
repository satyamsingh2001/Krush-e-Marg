import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../const/api_string.dart';
import '../../../database/database_helper2.dart';
import '../controller/payment_controller.dart';

PaymentController paymentController = Get.put(PaymentController());

List<Map<String, dynamic>> productListForApi = [];

Future<void> sendCartToApi(
    List<Map<String, dynamic>> productList,
    String totalAmount,
    String paymentMethod,
    String address) async {
  // const apiUrl = checkoutUrl;

  final prefs = await SharedPreferences.getInstance();
  final userid = prefs.getString("userId");
  final brearToken = prefs.getString("barrierToken");

  Map<String, dynamic> dataMap = {
    "user_id": userid,
    "address": address,
    "city": "Bulandshahr",
    "state": "UP",
    "pincode": "245412",
    "landmark": "This is my landmark",
    "payment_method": paymentMethod,
    "order_by":"user", // user, deliveryMan
    // "total_amount": totalAmount,
    "instruction": "instruction"
  };

  Map<String, dynamic> requestPayload = {
    'cart': productList,
    'data': dataMap,
  };

  try {
    final response = await http.post(
      Uri.parse(checkoutUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $brearToken'
        },     body: jsonEncode(requestPayload),
    );

    var data = jsonDecode(response.body);

    if (data['status'] == 1) {
      if (paymentMethod == 'online') {
        // paymentController.openPaymentPortal(data['paymentOption']);
      } else {
        paymentController.showSuccessDialog();
        deleteProduct();
      }
      if (kDebugMode) {
        print('Cart sent successfully.');
        print(data);
      }
    } else {
      if (kDebugMode) {
        print('Error sending cart. Status code: ${response.statusCode}');
        print(data);
        print('$userid ye hai');

      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error sending cart: $e');

    }
  }
}

RxList item1 = [].obs;
RxList<dynamic> fetchOffer = [].obs;
Future<void> adminOffer(String storeID) async {
  final response = await http.get(Uri.parse('$offerWithStoreUrl+$storeID'));
  var offerData = jsonDecode(response.body);
  if (offerData['status'] == 1) {
    fetchOffer.value = offerData['offers'];
    item1.value = List.generate(fetchOffer.length, (index) => false);
  } else {
    throw Exception('Failed to load');
  }
}

RxList items=[].obs;
RxList<dynamic> storeCoupon = [].obs;
Future<void> fetchCoupons(String storeID) async {
  final response = await http.get(Uri.parse(
      '$fetchCoupon+$storeID'));
  var couponData = jsonDecode(response.body);

  if(response.statusCode==200){
      storeCoupon.value = couponData;
      items.value = List.generate(storeCoupon.length, (index1) => false);
  }
}

RxList additionalProduct = [].obs;
Future<void> fetchAdditionalProduct(String storeID) async {
  final response = await http.get(
      Uri.parse('$additionProduct+$storeID'));

  var productData = jsonDecode(response.body);
  if (productData['status'] == 1) {
      additionalProduct.value= productData['data'];
  } else {
    throw Exception('Failed to load');
  }
}

var map;
Future storeWithId(String storeID) async {
  final response = await http.get(
    Uri.parse("$store_with_id+$storeID"),
  );
  var data = jsonDecode(response.body);
  if (data['status']==1) {
      map = data['data'];
  }
}