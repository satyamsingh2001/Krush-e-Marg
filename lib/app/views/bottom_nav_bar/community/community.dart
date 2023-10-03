import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:krush_e_marg/app/controller/api_controller.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/community/comment_page.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/community/utils/utils.dart';
import '../../../colors/colors_const.dart';
import '../../../const/const_string.dart';
import '../../../constwidgets/const_container.dart';
import '../../../constwidgets/const_textfield.dart';
import '../../../textstyles/textstyle_const.dart';
import '../bottom_nav_bar.dart';
import '../reels/widgets/const_video_player.dart';
import 'add_post.dart';
import 'controller/api.dart';
import 'controller/toggle_controller.dart';
import 'controller/update_ls_controller.dart';

class Community extends StatefulWidget {
  const Community({
    Key? key,
  }) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final CommunityController communityController = Get.find();
  final UpdateLSController updateLSController = Get.find();
  final ToggleController toggleController = Get.find();
  final CommentController commentController = Get.put(CommentController());
  final DeleteCommentController deleteCommentController = Get.put(DeleteCommentController());
  final PostCommunityController postCommunityController = Get.put(PostCommunityController());


  bool isDetailsVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    communityController.fetchComm();
  }

  void toggleDetailsVisibility() {
    setState(() {
      isDetailsVisible = !isDetailsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white10,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddPost()));
        },
        backgroundColor: AppColors.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.plus,
              size: 20,
            ),
            Text(
              "Post",
              style: AppTextStyles.kCaption12SemiboldTextStyle
                  .copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Krush e Marge'),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashBoardScreenMain(
                              currentIndex: 1,
                            )));
              },
              child: const Icon(Icons.search)),
          const SizedBox(
            width: 10,
          ),
          InkWell(onTap: () {}, child: const Icon(Icons.notifications)),
          const SizedBox(
            width: 10,
          ),
          InkWell(onTap: () {}, child: const Icon(Icons.shopping_cart)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: GetBuilder<CommunityController>(builder: (communityController) {
        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: ListView.builder(
              itemCount: communityController.commList.length,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index1) {
                final comm = communityController.commList[index1];
                List cPost = comm['community_images'];
                List comment = comm['commentLists'];

                return ConstantContainer(
                  color: AppColors.white,
                  borderColor: AppColors.white40,
                  radiusBorder: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColors.white20,
                            child: comm['profile_image_url'] != null
                                ? Image.network(
                                    '${comm['profile_image_url']}')
                                :Image.asset(appLogo,fit: BoxFit.fill,height: 40,width: 40,),
                            // const Icon(
                            //         CupertinoIcons.profile_circled,
                            //         color: AppColors.primary,
                            //         size: 30,
                            //       ),
                          ),
                          title: Text(
                            comm['username'],
                            // "User",
                            style: AppTextStyles.kBody17SemiboldTextStyle
                                .copyWith(color: AppColors.primary),
                          ),
                          subtitle: Text(
                            DateFormat("hh:mm a").format(
                                DateFormat("yyyy-MM-dd HH:mm:ss")
                                    .parse(comm['updated_at'])),
                            // comm['updated_at'].toString().substring(11,16),
                            // "21 hr",
                            style: AppTextStyles.kCaption12RegularTextStyle
                                .copyWith(color: AppColors.white100),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: Get.height * 0.5,
                          child: PageView.builder(
                            itemCount: cPost.length,
                            itemBuilder: (context, index2) {
                              final cPostContent = cPost[index2];
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: cPostContent['type'].toString() ==
                                              'image'
                                          ? Image.network(
                                              cPostContent['image_video_url']
                                                  .toString(),
                                              fit: BoxFit.cover,
                                              width: Get.width,
                                            )
                                          : CustomVideoPlayer(
                                              videoUrl: cPostContent[
                                                      'image_video_url']
                                                  .toString(),
                                            )),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: ConstantContainer(
                                      radiusBorder: 40,
                                      color: AppColors.white50,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            "${index2 + 1}/${cPost.length}", // Page number
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          comm['title'],
                          // "Mango",
                          style: AppTextStyles.kBody15SemiboldTextStyle
                              .copyWith(color: AppColors.white100),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: InkWell(
                            onTap:toggleDetailsVisibility,
                            child: SizedBox(
                              width: Get.width * 0.3,
                              child: Row(
                                children: [
                                  Text(
                                    "View Details",
                                    style: AppTextStyles.kBody15RegularTextStyle
                                        .copyWith(color: AppColors.white100),
                                  ),
                                  Icon(
                                   isDetailsVisible
                                    // communityController.isDetail[index1]
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down,
                                    size: 30.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible:isDetailsVisible,
                            child: Text(
                              comm['discription'],
                              // "Hello,what's going on?",
                              style: AppTextStyles.kBody15RegularTextStyle
                                  .copyWith(color: AppColors.white100),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${comm['likes']} Likes  ",
                              style: AppTextStyles.kCaption12RegularTextStyle
                                  .copyWith(color: AppColors.white70),
                            ),
                            Text(
                              "${comm['comments']} Comments  ",
                              style: AppTextStyles.kCaption12RegularTextStyle
                                  .copyWith(color: AppColors.white70),
                            ),
                            Text(
                              "${comm['shares']} Shares",
                              style: AppTextStyles.kCaption12RegularTextStyle
                                  .copyWith(color: AppColors.white70),
                            ),
                          ],
                        ),
                        const Divider(
                          color: AppColors.white40,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  communityController.toggleLikeUnlike(index1);
                                  if (communityController.isLikedList[index1]) {
                                    updateLSController.updateLikeShare(
                                        comm['id'], 'like', 'increment',comm['user_id']);
                                  } else {
                                    updateLSController.updateLikeShare(
                                        comm['id'], 'like', 'decrement',comm['user_id']);
                                  }
                                },
                                icon: communityController.isLikedList[index1]
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(Icons.favorite_border)),
                            IconButton(
                                onPressed: () {
                                  Get.to(CommentPage(comment: comment,id:comm['id'].toString()));
                                },
                                icon: const Icon(CupertinoIcons.chat_bubble)),
                            IconButton(
                                onPressed: () {

                                  updateLSController.updateLikeShare(
                                      comm['id'], 'share', 'increment',comm['user_id']);
                                  shareContent();
                                },
                                icon: const Icon(Icons.share)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
                // const LikeComment();
              }),
        );
      }),
    );
  }
}
