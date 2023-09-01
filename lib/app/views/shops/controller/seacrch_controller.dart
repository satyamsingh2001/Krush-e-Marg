import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../../../const/api_string.dart';
import '../../../controller/api_controller.dart';

class SearchController extends GetxController{
  List modulesName = [];
  RxBool loading = true.obs;
  Future<void> fetchModules() async {
    loading.value = false;
    List<String> storedStrings = await loadStrings();
    String lat = storedStrings[0].toString();
    String long = storedStrings[1].toString();

    final response = await http.get(Uri.parse('$moduleUrl+$lat,$long'));
    List modules = jsonDecode(response.body)['data'];

    if (response.statusCode == 200) {
        modulesName = modules;
        filteredModulesName.value = List.from(modules); // Initialize filteredModulesName with the same data
        update();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  RxList filteredModulesName = [].obs;
  void filterModules(String query) {
    update();
      if (query.isEmpty) {
        // If the search query is empty, show all modules
        filteredModulesName.value = List.from(modulesName);
      } else {
        // Filter modules based on the search query
        filteredModulesName.value = modulesName
            .where((module) => module['name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
            .toList();
      }
  }
}