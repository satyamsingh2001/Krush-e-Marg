import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:krush_e_marg/app/controller/api_controller.dart';

import '../../../colors/colors_const.dart';
import '../../../constwidgets/const_container.dart';
import '../../../constwidgets/const_textfield.dart';
import '../../../textstyles/textstyle_const.dart';
import 'controller/api.dart';
import 'controller/update_ls_controller.dart';

class CommentPage extends StatefulWidget {
  final List comment;
  final String? id;
  const CommentPage({Key? key, required this.comment, this.id}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  final CommentController commentController = Get.find();
  final CommunityController communityController = Get.find();
  final UpdateLSController updateLSController = Get.find();
  final DeleteCommentController deleteCommentController = Get.find();
  TextEditingController  textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    comment = widget.comment;
    id=widget.id!;
    // commentController.postComment(id);
  }
  List comment =[];
  String id="";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text("${comment.length} Comments  ",),
      ),
      body: GetBuilder<CommunityController>(
        builder: (communityController) {
          return   NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: ListView(
              children: [
                ListView.builder(
                    itemCount: comment.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder:
                        (context, index3) {
                      final commDetails =
                      comment[index3];
                      return ConstantContainer(
                        color:
                        AppColors.white30,
                        radiusBorder: 10,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            ListTile(
                              leading:
                              CircleAvatar(
                                backgroundImage:
                                NetworkImage(
                                    commDetails['profile_image_url']
                                        .toString()),
                                // "https://imgs.search.brave.com/4ajZclzELz9Ru-VqaIl_Qi81Sd4-YI7NJq0eKTzvbhg/rs:fit:500:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJzLmNvbS9p/bWFnZXMvaGQvY29v/bC1wcm9maWxlLXBp/Y3R1cmUta3B3anZq/dzU0MzRxZnpvMy5q/cGc"),
                              ),
                              title: Text(
                                commDetails[
                                'username'],
                                style: AppTextStyles
                                    .kBody15SemiboldTextStyle
                                    .copyWith(
                                    color: AppColors
                                        .primary),
                              ),
                              subtitle: Text(
                                DateFormat(
                                    "hh:mm a")
                                    .format(DateFormat(
                                    "yyyy-MM-dd HH:mm:ss")
                                    .parse(commDetails[
                                'updated_at'])),
                                style: AppTextStyles
                                    .kBody15RegularTextStyle
                                    .copyWith(
                                    color: AppColors
                                        .white100),
                              ),
                              trailing:
                              IconButton(
                                  onPressed:
                                      () {
                                     deleteCommentController.deleteComment(id,commDetails['id'].toString());

                                      },
                                  icon:
                                  const Icon(
                                    CupertinoIcons
                                        .delete,
                                    color: Colors
                                        .red,
                                  )),
                            ),
                            Text(
                              "${" "+commDetails['comment']}\n",
                              // " hello what are you doing ?\n ",
                              style: AppTextStyles
                                  .kBody17RegularTextStyle
                                  .copyWith(
                                  color: AppColors
                                      .white100),
                            )
                          ],
                        ),
                      );
                    }),
                const SizedBox(height: 100,)

              ],
            ),
          );
        }
      ),
      bottomSheet : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
             Expanded(
                child: ConstTextField(
                  controller: textController,
                  hintText:
                  "Write your comment here...",
                )),
            IconButton(
                onPressed: () {
                  commentController.postComment(id,textController.text);
                },
                icon: const Icon(
                    Icons.send))
          ],
        ),
      ),
    );
  }
}
