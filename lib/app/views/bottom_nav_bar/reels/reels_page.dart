import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../community/utils/utils.dart';
import 'controller/reels_controller.dart';
import 'widgets/const_video_player.dart';

class Reels extends StatefulWidget {
  const Reels({Key? key}) : super(key: key);

  @override
  State<Reels> createState() => _ReelsState();
}

class _ReelsState extends State<Reels> {
  PageController controller = PageController();
  VideoPlayerController? _videoPlayerController;
  final ReelsController reelsController = Get.put(ReelsController());


  @override
  void initState() {
    super.initState();
    reelsController.fetchReels();
  }


  @override
  void dispose() {
    super.dispose();
    _videoPlayerController?.dispose(); // Dispose of the video player
    reelsController.fetchReels();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ReelsController>(builder: (reelsController) {
      return reelsController.reelsList.isNotEmpty?Column(
        children: [
          Expanded(
            child: PageView.builder(
                // itemCount: videoUrl.length,
                itemCount: reelsController.reelsList.length,
                scrollDirection: Axis.vertical,
                onPageChanged: (index) {

                },
                itemBuilder: (BuildContext context, int index) {
                  final reels = reelsController.reelsList[index];
                  final reelsData = reels['image_video_url'];
                  if(reelsData.isNotEmpty) {
                    return Stack(
                      children: [
                        Container(
                            height: size.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: CustomVideoPlayer(videoUrl:reelsData)
                          // child: CustomVideoPlayer(videoUrl:videoUrl)
                        ),
                      ],
                    );
                  }else{
                    circularIndicator();
                  }
                  return null;

                }),
          ),
        ],
      ):circularIndicator();
    });
  }


}



//like
// Positioned(
//   bottom: 15,
//   right: 0,
//   left: 0,
//   child: SizedBox(
//     height: size.height * 0.07,
//     // color: Colors.white30,
//     child: Row(
//       mainAxisAlignment:
//       MainAxisAlignment.spaceAround,
//       crossAxisAlignment:
//       CrossAxisAlignment.center,
//       children: [
//         Stack(
//           children: [
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(
//                 Icons.arrow_circle_down_rounded,
//                 size: 30,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         // Stack(
//         //   children: [
//         //     IconButton(
//         //       onPressed: () {
//         //         setState(() {
//         //           isLiked[_currentPageIndex] =
//         //           !isLiked[_currentPageIndex];
//         //           _isLiked = !_isLiked;
//         //           if (_isLiked) {
//         //             likeCount++;
//         //           } else {
//         //             likeCount--;
//         //           }
//         //         });
//         //         updadateLikeShareDownload(
//         //             sendId.toString(),
//         //             sendType.toString());
//         //       },
//         //       icon: isLiked[_currentPageIndex]
//         //           ? const Icon(
//         //         CupertinoIcons.heart_fill,
//         //         size: 30,
//         //         color: Colors.red,
//         //       )
//         //           : const Icon(
//         //         CupertinoIcons.heart,
//         //         size: 30,
//         //         color: Colors.white,
//         //       ),
//         //     ),
//         //   ],
//         // ),
//         Stack(
//           children: [
//             IconButton(
//               onPressed: () {
//                 shareContent();
//               },
//               icon: const Icon(
//                 Icons.send,
//                 size: 30,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// )