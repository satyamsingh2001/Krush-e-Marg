import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/views/story/stories_details.dart';
import '../../controller/api_controller.dart';

class StoriesStore extends StatefulWidget {
  const StoriesStore({super.key});

  @override
  State<StoriesStore> createState() => _StoryWidgetScrollState();
}

class _StoryWidgetScrollState extends State<StoriesStore> {
  StoryController storyController = Get.put(StoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storyController.fetchStory();
    // storyController.fetchStore();
  }
  bool _isPressed = false;
  // List seenStory = [];
  // List storeList = [];


  // Future<void> fetchStory() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final brearToken = prefs.getString("barrierToken");
  //   // final id = prefs.getString("id");
  //
  //   final response = await http.get(Uri.parse(storyUrl), headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $brearToken',
  //   });
  //
  //   var data = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     storeList = data['data'];
  //     // print(data);
  //     // print(brearToken);
  //     // print("sssssssssssssssssssssssssssssssssssssss");
  //     setState(() {});
  //   } else {
  //     throw Exception('Failed to load categories');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<StoryController>(
      builder: (storyController) {
        return SizedBox(
          height: 70,
          width: size.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: storyController.storeList.length,
              itemBuilder: (BuildContext context, int index) {
                // return StoryWidget(storyprofile: storeList[index]['logo_url'].toString());
                final store = storyController.storeList[index];
                final story = store['story'];
                // print(story);
                // print("Satyam");
                return GestureDetector(
                  onTap: () {
                    Get.to(
                        StoriesDetails(sendStory: story,)
                    );
                    setState(() {
                      _isPressed = !_isPressed;
                      storyController.seenStory[index]=true;

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
                              // color: storyController.seenStory[index] ? AppColors.primary : Colors.grey,
                              width: 3)),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: NetworkImage(store
                                    ['storeImage']
                                .toString()),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      }
    );
  }
}
