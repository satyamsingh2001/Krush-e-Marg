import 'dart:convert';
import 'package:krush_e_marg/app/views/story/stories_details.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../colors/colors_const.dart';
import '../../const/api_string.dart';
import '../../controller/api_controller.dart';

class StoriesStore extends StatefulWidget {
  const StoriesStore({super.key});

  @override
  State<StoriesStore> createState() => _StoryWidgetScrollState();
}

class _StoryWidgetScrollState extends State<StoriesStore> {
  // StoryController storyController = Get.put(StoryController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchStore();
    storyController.fetchStore();
  }

  StoryController storyController = Get.find();

  //
  // Future<List<String>> loadStrings() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? strings = prefs.getStringList('strings');
  //   return strings ?? [];
  // }
  //
  // List seenStory=[];
  // List fetchStoryStore = [];
  // Future<void> fetchStore() async {
  //   List<String> storedStrings = await loadStrings();
  //   String lat = storedStrings[0].toString();
  //   String long = storedStrings[1].toString();
  //
  //   final response = await http.get(
  //       Uri.parse('$storiesStoreurl+$lat,$long'));
  //   setState(() {
  //     fetchStoryStore = jsonDecode(response.body)['storyStores'];
  //   });
  //   seenStory = List.generate(fetchStoryStore.length, (index) => false);
  // }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 70,
      width: size.width,
      child: GetBuilder<StoryController>(
        builder: (storyController) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: storyController.fetchStoryStore.length,
              itemBuilder: (BuildContext context, int index){
            // return StoryWidget(storyprofile: fetchStoryStore[index]['logo_url'].toString());
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      // _isPressed = !_isPressed;
                      storyController.seenStory[index]=true;
                      Get.to(
                          StoriesDetails(storeId: storyController.fetchStoryStore[index]['id'].toString(),)
                      );
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.transparent,
                          border: Border.all(
                              color: storyController.seenStory[index]! ? AppColors.primary : Colors.grey,
                              width: 3)),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: NetworkImage(storyController.fetchStoryStore[index]['logo_url'].toString()),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: const BorderRadius.all( Radius.circular(30)),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
          });
        }
      ),
    );
  }
}
