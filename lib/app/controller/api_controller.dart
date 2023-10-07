import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

// class BannerController extends GetxController {
//   RxList categories = [].obs;
//   Future<void> fetchBanner() async {
//     final prefs = await SharedPreferences.getInstance();
//     final brearToken = prefs.getString("barrierToken");
//     // final id = prefs.getString("id");
//
//     final response = await http.get(Uri.parse(bannerUrl), headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $brearToken',
//     });
//
//     var suraj = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       categories.value = suraj['data'];
//       update();
//     } else {
//       throw Exception('Failed to load categories');
//     }
//   }
// }

class BannerController extends GetxController {
  RxList<String> hyperlinkType = <String>[].obs;
  RxList<String> hyperlink = <String>[].obs;
  RxList<String> bannerType = <String>[].obs;
  RxList<String> bannerImage = <String>[].obs;
  RxList<String> position = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBanner();
  }

  Future<void> fetchBanner() async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    final response = await http.get(Uri.parse(bannerUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $brearToken',
      // Add your authorization header here if needed.
    });

    if (response.statusCode == 200) {
      final suraj = jsonDecode(response.body)['data'] as List<dynamic>;

      hyperlinkType.assignAll(suraj.map((data) => data['hyperlinkType'].toString()));
      hyperlink.assignAll(suraj.map((data) => data['hyperlink'].toString()));
      bannerType.assignAll(suraj.map((data) => data['bannerType'].toString()));
      bannerImage.assignAll(suraj.map((data) => data['image_url'].toString()));
      position.assignAll(suraj.map((data) => data['display'].toString()));
    } else {
      throw Exception('Failed to load categories');
    }
  }
}

// class AdminOfferController extends GetxController {
//   RxBool loading = true.obs;
//   RxList fetchAdminOffer = [].obs;
//   Future<void> adminOffer() async {
//     loading.value = false;
//     List<String> storedStrings = await loadStrings();
//     // String lat = storedStrings[0].toString();
//     // String long = storedStrings[1].toString();
//     String lat = '26.8467';
//     String long = '80.9462';
//
//     final response = await http.get(Uri.parse('$offerUrl+$lat,$long'));
//     var offerData = jsonDecode(response.body);
//     // fetchAdminOffer = offerData['offers'];
//     if (offerData['status'] == 1) {
//       fetchAdminOffer.value = offerData['offers'];
//       update();
//     } else {
//       throw Exception('Failed to load');
//     }
//     update();
//   }
// }

class CategoriesController extends GetxController {
  List categoriesList = [];
  Future<void> fetchCat() async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    // final id = prefs.getString("id");

    final response = await http.get(Uri.parse(categoryUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $brearToken',
    });

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      categoriesList = data['data'];
      // print(data);
      // print(brearToken);
      // print("sssssssssssssssssssssssssssssssssssssss");
      update();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}

class SubCatController extends GetxController {
  RxList subCatList = [].obs;
  // RxList selectedIndex = [].obs;
  Future<void> fetchSubCat(catId) async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    // final id = prefs.getString("id");

    final response = await http.get(Uri.parse('$subCatUrl$catId'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $brearToken',
    });

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      subCatList.value = data['data'];
      // selectedIndex =
      //     RxList.generate(subCatList.length, (index) => false);
      // selectedIndex[0] = true;
      // print(data);
      // print(brearToken);
      // print("sssssssssssssssssssssssssssssssssssssss");
      update();
    } else {
      throw Exception('Failed to load categories');
    }
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
    final brearToken = prefs.getString("barrierToken");
    final id = prefs.getString("userId");
    final response = await http.get(Uri.parse('$baseurl/api/user/address/$id'),
    headers: {
      'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $brearToken',
    });

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

  Future<void> deleteAddress(
      int addressId
      ) async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    final id = prefs.getString("userId");

    final response =
    await http.get(Uri.parse("$delAddressUrl$id/$addressId"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $brearToken',
    },
    );

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {

      // // commentList = data['comment'];
      Get.back();
      Get.snackbar("address", "deleted",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),// Snack Position
        duration: const Duration(seconds: 3), // Duration to display
        backgroundColor: Colors.greenAccent, // Snackbar background color
        colorText: Colors.black,
      );
      update();
    } else {
      throw Exception('Failed to load ');
    }
  }
}

class StoryController extends GetxController {
  List seenStory = [];
  List storeList = [];

  Future<void> fetchStory() async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    // final id = prefs.getString("id");

    final response = await http.get(Uri.parse(storyUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $brearToken',
    });

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // storeList = data;
      for(int i=0; i<data.length;i++){
        if(data[i]['story'] != null){
          storeList=data;
        }
      }

      update();
    } else {
      throw Exception('Failed to load categories');
    }
  }

}

// class ModuleController extends GetxController {
//   List modulesName = [];
//   Future<void> fetchModules() async {
//     List<String> storedStrings = await loadStrings();
//     // String lat = storedStrings[0].toString();
//     // String long = storedStrings[1].toString();
//     String lat = '26.8467';
//     String long = '80.9462';
//
//     final response = await http.get(Uri.parse('$moduleUrl+$lat,$long'));
//     modulesName = jsonDecode(response.body)['data'];
//     update();
//     if (response.statusCode == 200) {
//     } else {
//       throw Exception('Failed to load');
//     }
//   }
// }


class UpdateController extends GetxController {
  Map updateList = {};
  Future<void> fetchUpdates() async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    final id = prefs.getString("userId");

    final response = await http.post(Uri.parse("$updateProfileUrl$id"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $brearToken',
    });

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      updateList = data['data'];
      // print(data);
      // print("SatyamSingh");
      // print("sssssssssssssssssssssssssssssssssssssss");
      update();
    } else {
      print("dat not found");
      print("Metro");
      throw Exception('Failed to load categories');
    }
  }
}

class CommunityController extends GetxController {
  RxList commList = [].obs;

  RxList isLikedList = [].obs;
  RxList isDetail = [].obs;

  Future<void> fetchComm() async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    final id = prefs.getString("userId");

    final response = await http.get(Uri.parse("$commUrl$id"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $brearToken',
    });

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      commList.value = data['community'];
      isLikedList.value = List.generate(commList.length, (index) => false);
      for(int i=0;i<commList.length;i++){
        if(commList[i]['userLikeStatus']==0){
          isLikedList[i]=false;
        }else{
          isLikedList[i]=true;
        }
      }
      print(isLikedList);
      // isDetail.value = List.generate(commList.length, (index) => false);/
      // print(data);
      // print("SatyamSingh");
      // print("sssssssssssssssssssssssssssssssssssssss");
      update();
    } else {
      // print("dat not found");
      // print("Metro");
      throw Exception('Failed to load categories');
    }
  }
  void toggleLikeUnlike(int index) {
    isLikedList[index] = !isLikedList[index];
    update();
  }
   toggleDetails(int index) {
    isDetail[index] = !isDetail[index];
    update();
  }
}


