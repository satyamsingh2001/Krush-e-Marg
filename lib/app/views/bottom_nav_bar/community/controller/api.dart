import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../const/api_string.dart';
import '../../../../controller/api_controller.dart';

class CommentController extends GetxController {
  // RxList commentList = [].obs;

  final CommunityController communityController = Get.find();

  Future<void> postComment(
    commId,String comment
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    final id = prefs.getString("userId");

    final response =
        await http.post(Uri.parse("$commentUrl$commId/$id"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $brearToken',
    },
              body: jsonEncode(<dynamic, dynamic>{
              "comment": comment,

            }),

    );

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
           communityController.fetchComm();
      // // commentList = data['comment'];
      Get.back();
      Get.snackbar("comment", "posted",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),// Snack Position
        duration: const Duration(seconds: 3), // Duration to display
        backgroundColor: Colors.greenAccent, // Snackbar background color
        colorText: Colors.black,
      );
      // update();
    } else {
      throw Exception('Failed to load ');
    }
  }
}


class DeleteCommentController extends GetxController {

  final CommunityController communityController = Get.find();

  Future<void> deleteComment(
    commId,String commentId
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    // final id = prefs.getString("userId");

    final response =
        await http.get(Uri.parse("${commentUrl}delete/$commId/$commentId"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $brearToken',
    },
    );

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
           communityController.fetchComm();
      // // commentList = data['comment'];
      Get.back();
      Get.snackbar("comment", "deleted",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),// Snack Position
        duration: const Duration(seconds: 3), // Duration to display
        backgroundColor: Colors.greenAccent, // Snackbar background color
        colorText: Colors.black,
      );
      // update();
    } else {
      throw Exception('Failed to load ');
    }
  }
}


// class PostCommunityController extends GetxController {
//
//   final CommunityController communityController = Get.find();
//
//   Future<void> postCommunity(
//       String title,String dis,String video,
//       ) async {
//     final prefs = await SharedPreferences.getInstance();
//     final brearToken = prefs.getString("barrierToken");
//     final id = prefs.getString("userId");
//
//     final response =
//     await http.post(Uri.parse("$postCommUrl/$id"), headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $brearToken',
//     },
//       body: jsonEncode(<dynamic, dynamic>{
//         "title": title,
//         "discription": dis,
//         "video_img": video,
//
//       }),
//
//     );
//
//     var data = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       communityController.fetchComm();
//       // // commentList = data['comment'];
//       Get.back();
//       Get.snackbar("Post", "new post posted",
//         snackPosition: SnackPosition.BOTTOM,
//         margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),// Snack Position
//         duration: const Duration(seconds: 3), // Duration to display
//         backgroundColor: Colors.greenAccent, // Snackbar background color
//         colorText: Colors.black,
//       );
//       // update();
//     } else {
//       throw Exception('Failed to load ');
//     }
//   }
// }






class PostCommunityController extends GetxController {

  final CommunityController communityController = Get.find();


  // Future<void> uploadDataAndFile(String title, String description, List<PlatformFile> files) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final bearerToken = prefs.getString("barrierToken");
  //   final id = prefs.getString("userId");
  //
  //   try {
  //     final url = Uri.parse('$postCommUrl/$id'); // Replace with your API endpoint
  //
  //     // Create a multipart request
  //     final request = http.MultipartRequest('POST', url);
  //     request.headers['Authorization'] = 'Bearer $bearerToken';
  //
  //     // Add fields (title and description) to the request
  //     request.fields['title'] = title;
  //     request.fields['description'] = description;
  //
  //     // Add the files to the request
  //     for (var file in files) {
  //       final tempFile = File(file.path!); // Create a File from the PlatformFile's path
  //       final stream = tempFile.openRead(); // Open the file for reading
  //
  //       request.files.add(
  //         http.MultipartFile(
  //           'files', // Field name for the files (you can change this)
  //           stream,
  //           await tempFile.length(), // Use the length of the temporary file
  //           filename: file.name, // Use the file name
  //         ),
  //       );
  //     }
  //
  //
  //
  //     // Send the request and await for the response
  //     final response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       // Request was successful
  //       communityController.fetchComm();
  //       Get.back();
  //     Get.snackbar("Post", "new post posted",
  //       snackPosition: SnackPosition.BOTTOM,
  //       margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),// Snack Position
  //       duration: const Duration(seconds: 3),
  //       backgroundColor: Colors.greenAccent,
  //       colorText: Colors.black,
  //     );
  //
  //       print('Data and files uploaded successfully');
  //     } else {
  //       // Request failed
  //       print('Failed to upload data and files. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Handle any errors that may occur during the request
  //     print('Error uploading data and files: $e');
  //   }
  // }
}



