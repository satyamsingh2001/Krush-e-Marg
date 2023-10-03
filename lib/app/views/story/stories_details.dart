import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import '../../colors/colors_const.dart';

class StoriesDetails extends StatefulWidget {
  final List? sendStory;
  const StoriesDetails({super.key, this.sendStory});
  @override
  _StoriesDetailsState createState() => _StoriesDetailsState();
}

class _StoriesDetailsState extends State<StoriesDetails> {
  final storyController = StoryController();

  bool _loading =true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchStory=widget.sendStory!;
    for(int i=0;i<fetchStory.length;i++){
      var fetchImgVideo = fetchStory[i]['image_video_url'];
      var storyType = fetchStory[i]['type'];
      images.add(fetchImgVideo);
      mediaType.add(storyType);
    }
    // print(widget.sendStory);
    if(fetchStory.isNotEmpty){
      _loading = false;
    }
    setState(() {
    });
  }

  List fetchStory = [];
  // Future<void> _fetchStory() async {
  //   final response = await http.get(
  //       Uri.parse('$storyUrl+$storeid'));
  //   fetchStory = jsonDecode(response.body)['story'];
  //
  //   for(int i=0;i<fetchStory.length;i++){
  //     var fetchImgVideo = fetchStory[i]['image_video_url'];
  //     var storyType = fetchStory[i]['type'];
  //     setState(() {
  //       images.add(fetchImgVideo);
  //       mediaType.add(storyType);
  //     });
  //   }
  //   if (response.statusCode == 200) {
  //     _loading = false;
  //   } else {
  //     throw Exception('Failed to load categories');
  //   }
  // }

  List mediaType = [];
  List images = [];

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _loading?Container(
      color: AppColors.white,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox(
              height: 70,
              width: 70,
              child: CircularProgressIndicator(color: AppColors.primary,strokeWidth: 2.5,)),
          Image.asset('assets/images/applogo.png',height: 60,width: 60,),
        ],
      ),
    ):Scaffold(
      // floatingActionButton: SizedBox(
      //   height: 40,
      //   width: size.width*0.9,
      //   child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //           backgroundColor: AppColors.primary700,
      //           shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(20))),
      //       onPressed: () {
      //         Navigator.of(context).push(MaterialPageRoute(
      //             fullscreenDialog: true,
      //             builder: (context) => StoreDetails(storeID: widget.storeId,)));
      //       },
      //       child: const Text('Visit store')),
      // ),
      body: StoryView(
        storyItems: [
          for(int i=0;i<mediaType.length;i++)
          if (mediaType[i] == "text")
            StoryItem.text(title: images[i], backgroundColor: Colors.blue)
          else if (mediaType[i] == 'image')
            StoryItem.pageImage(url: images[i], caption:'', controller: storyController)
          else if (mediaType[i] == 'video')
              StoryItem.pageVideo(images[i], caption: '', controller: storyController)
        ],
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.pop(context);
          }
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),

    );
  }
}