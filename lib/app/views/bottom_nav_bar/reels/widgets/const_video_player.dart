import 'package:flutter/material.dart';
import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/community/utils/utils.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const CustomVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        // Ensure the video starts playing when initialized
        _videoPlayerController.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  // void _initializeVideoPlayer() async {
  //   await _videoPlayerController.initialize();
  //   // Pause the video after initialization
  //   _videoPlayerController.pause();
  //   setState(() {});
  // }

  void _toggleVideoPlayback() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
      } else {
        _videoPlayerController.play();
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _toggleVideoPlayback,
              child: _videoPlayerController.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
                  : circularIndicator(), // Show a loading indicator until the video is initialized
            ),
          ),
          Visibility(
            visible: !_videoPlayerController.value.isPlaying,
            child: const Icon(
              Icons.play_arrow,
              size: 80,
              color: AppColors.primary,
            ),
          )
        ],
      ),
    );
  }
}





// class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
//   late VideoPlayerController _videoPlayerController;
//
//   @override
//   void initState() {
//     super.initState();
//     _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         // Ensure the video starts playing when initialized
//         _videoPlayerController.play();
//         setState(() {});
//       });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _videoPlayerController.dispose();
//   }
//
//   void _toggleVideoPlayback() {
//     if (_videoPlayerController.value.isPlaying) {
//       _videoPlayerController.pause();
//     } else {
//       _videoPlayerController.play();
//     }
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: _toggleVideoPlayback,
//                   child: _videoPlayerController.value.isInitialized
//                       ? AspectRatio(
//                     aspectRatio: _videoPlayerController.value.aspectRatio,
//                     child: VideoPlayer(_videoPlayerController),
//                   )
//                       : Center(child: circularIndicator()), // Show a loading indicator until the video is initialized
//                 ),
//               ],
//             ),
//           ),
//           Visibility(
//             visible: !_videoPlayerController.value.isPlaying,
//             child: const Icon(
//               Icons.play_arrow,
//               size: 80,
//               color: AppColors.primary,
//             ),
//           )
//
//         ],
//       ),
//     );
//   }
// }