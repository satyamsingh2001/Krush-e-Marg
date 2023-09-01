import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/api_string.dart';
import '../database/database_helper2.dart';

Future<List<String>> loadStrings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? strings = prefs.getStringList('strings');
  return strings ?? [];
}

class BannerController extends GetxController {
  RxList banner = [].obs;
  Future<void> fetchBanner() async {
    List<String> storedStrings = await loadStrings();
    // String lat = storedStrings[0].toString();
    // String long = storedStrings[1].toString();
    String lat = '26.8467';
    String long = '80.9462';

    final response = await http.get(Uri.parse('$bannerUrl+$lat,$long'));
    banner.value = jsonDecode(response.body);
    update();
  }
}

class AdminOfferController extends GetxController {
  RxBool loading = true.obs;
  RxList fetchAdminOffer = [].obs;
  Future<void> adminOffer() async {
    loading.value = false;
    List<String> storedStrings = await loadStrings();
    // String lat = storedStrings[0].toString();
    // String long = storedStrings[1].toString();
    String lat = '26.8467';
    String long = '80.9462';

    final response = await http.get(Uri.parse('$offerUrl+$lat,$long'));
    var offerData = jsonDecode(response.body);
    // fetchAdminOffer = offerData['offers'];
    if (offerData['status'] == 1) {
      fetchAdminOffer.value = offerData['offers'];
      update();
    } else {
      throw Exception('Failed to load');
    }
    update();
  }
}

class CategoriesController extends GetxController {
  List<Map<String, dynamic>> categoryNames = [];
  Future<void> fetchCategories() async {
    List<String> storedStrings = await loadStrings();
    // String lat = storedStrings[0].toString();
    // String long = storedStrings[1].toString();
    String lat = '26.8467';
    String long = '80.9462';

    final response = await http.get(Uri.parse('$categoryUrl+$lat,$long'));
    categoryNames = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    update();
  }
}

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
      // print('updated');
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

class AddressController extends GetxController {
  List fetchAddress = [];
  String address = "";
  String label = "";
  RxBool isLoading = true.obs;
  // bool isLoading = true;
  Future<void> fetchSavedAddress() async {
    isLoading.value = false;
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.get(Uri.parse('$baseurl/api/address/$userid'));

    fetchAddress = jsonDecode(response.body)['data'];
    address =
        "${fetchAddress[0]['house_floor_no'] ?? ''} ${fetchAddress[0]['name'] ?? ''} ${fetchAddress[0]['landmark'] ?? ''} ${fetchAddress[0]['map']}";
    label = fetchAddress[0]['label'].toString();
    if (response.statusCode == 200) {
      update();
    } else {
      throw Exception('Failed to load categories');
    }
    update();
  }
}

class StoryController extends GetxController {
  List seenStory = [];
  List fetchStoryStore = [];
  Future<void> fetchStore() async {
    List<String> storedStrings = await loadStrings();
    // String lat = storedStrings[0].toString();
    // String long = storedStrings[1].toString();
    String lat = '26.8467';
    String long = '80.9462';

    final response = await http.get(
        Uri.parse('$storiesStoreurl+$lat,$long'));
    fetchStoryStore = jsonDecode(response.body)['storyStores'];
    seenStory = List.generate(fetchStoryStore.length, (index) => false);
    update();
  }
}

class ModuleController extends GetxController {
  List modulesName = [];
  Future<void> fetchModules() async {
    List<String> storedStrings = await loadStrings();
    // String lat = storedStrings[0].toString();
    // String long = storedStrings[1].toString();
    String lat = '26.8467';
    String long = '80.9462';

    final response = await http.get(Uri.parse('$moduleUrl+$lat,$long'));
    modulesName = jsonDecode(response.body)['data'];
    update();
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load');
    }
  }
}
