import 'dart:async';
import 'package:get/get.dart';
import '../database/database_helper2.dart';

class ProductController extends GetxController {
  List<Product> productList = [];
  late Timer _updateTimer;

  @override
  void onInit() {
    super.onInit();
    startUpdating();
  }

  void startUpdating() {
    _updateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      fetchProducts(); // Call fetchProducts() every second
    });
  }

  void fetchProducts() async {
    final products = await ProductDatabase.instance.fetchProducts();
    if (productList.isEmpty) {
      productList = products;
    } else {
      productList.clear();
      productList = products;
    }
    update();
  }

  @override
  void onClose() {
    _updateTimer.cancel();
    super.onClose();
  }
}