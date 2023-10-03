import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/constwidgets/const_container.dart';
import 'package:krush_e_marg/app/constwidgets/const_textfield.dart';
import 'package:krush_e_marg/app/controller/api_controller.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/community/controller/api.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/community/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../../const/api_string.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PostCommunityController postCommunityController = Get.find();
  final CommunityController communityController = Get.find();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  VideoPlayerController? _videoPlayerController;
  PlatformFile? _imageFile;
  PlatformFile? _videoFile;
  List<PlatformFile> _mediaFiles = [];

  Future<void> uploadDataAndFile(String title, String description, List<PlatformFile> files) async {
    final prefs = await SharedPreferences.getInstance();
    final bearerToken = prefs.getString("barrierToken");
    final id = prefs.getString("userId");

    try {
      final url = Uri.parse('$postCommUrl/$id'); // Replace with your API endpoint

      // Create a multipart request
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $bearerToken';

      // Add fields (title and description) to the request
      request.fields['title'] = title;
      request.fields['discription'] = description;

      // Add the files to the request
      for (var file in files) {
        final tempFile = File(file.path!); // Create a File from the PlatformFile's path
        final stream = tempFile.openRead(); // Open the file for reading

        request.files.add(
          http.MultipartFile(
            'video_img[]', // Field name for the files (you can change this)
            stream,
            await tempFile.length(), // Use the length of the temporary file
            filename: file.name, // Use the file name
          ),
        );
      }



      // Send the request and await for the response
      final response = await request.send();

      if (response.statusCode == 200) {
        // Request was successful
        Get.back();
        Get.snackbar("Post", "new post posted",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),// Snack Position
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.greenAccent,
          colorText: Colors.black,
        );
        communityController.fetchComm();

      } else {
        // Request failed
      }
    } catch (e) {
      // Handle any errors that may occur during the request
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text("Create Post",style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<PostCommunityController>(
              builder: (postCommunityController) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      if (_imageFile != null)
                        Image.file(File(_imageFile!.path!)),

                      // Display selected video
                      if (_videoFile != null)
                        _videoPlayerController != null
                            ? AspectRatio(
                          aspectRatio: _videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController!),
                        )
                            : const CircularProgressIndicator(),
                      constText("Title"),
                      ConstTextField(
                        controller: title,
                        hintText: 'Enter Title',validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Please enter your title';
                        }
                        return null;
                      },),
                      constText("Description"),
                      ConstTextField(
                        controller: description,
                        hintText: 'Enter Description',validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Please enter your description';
                        }
                        return null;
                      },
                        maxLine: null,
                      ),
                      const SizedBox(height: 10,),
                      GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: _mediaFiles.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final file = _mediaFiles[index];
                          return MediaItemWidget(file);
                        },
                      ),
                      InkWell(
                        onTap: pickMediaFiles,
                        child: ConstantContainer(
                          borderColor: AppColors.white100,
                          radiusBorder: 5,
                          borderWidth: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Upload images/videos",style: AppTextStyles.kBody17RegularTextStyle.copyWith(color: AppColors.primary),),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Center(
                        child: InkWell(
                          onTap: (){

                            if(_formKey.currentState!.validate()){
                              List<PlatformFile> mediaFiles = _mediaFiles;
                              uploadDataAndFile(title.text, description.text, mediaFiles);

                            }
                          },
                          child: ConstantContainer(
                            color: AppColors.primary,
                            radiusBorder: 20,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 8),
                              child: Text("Post",style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white),),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                );
              }
          ),
        ),
      ),
    );
  }

  Widget constText(text){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text,style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white100),),
    );
  }


  Future<void> pickMediaFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'mp4', 'mov'],
    );

    if (result != null) {
      setState(() {
        _mediaFiles = result.files;
      });
    }
  }


}


class MediaItemWidget extends StatelessWidget {
  final PlatformFile mediaFile;

  const MediaItemWidget(this.mediaFile, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
      ),
      child: mediaFile.extension == 'mp4'
          ? VideoWidget(mediaFile)
          : Image.file(File(mediaFile.path!)),
    );
  }
}

class VideoWidget extends StatefulWidget {
  final PlatformFile videoFile;

  const VideoWidget(this.videoFile, {super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();

}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoFile.path!))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : circularIndicator();
  }
}