import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../colors/colors_const.dart';
import '../../../../textstyles/textstyle_const.dart';

void shareContent() {
  try {
    String text = 'Check out this awesome app! Download it now.';
    String url = 'https://www.google.com';

    String formattedContent = '$text\n$url';

    Share.text('Share App', formattedContent, url);
  } catch (e) {
    if (kDebugMode) {
      print('Error sharing: $e');
    }
  }
}

Center circularIndicator(){
  return const Center(child: CircularProgressIndicator(color: AppColors.primary,));
}

 dialogBox(BuildContext context ,String title,String content,Widget widget){
  showDialog(context: context, builder: (context)=>AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      TextButton(
        child: Text('Cancel',style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white100),),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      widget,
    ],
  ));
}
