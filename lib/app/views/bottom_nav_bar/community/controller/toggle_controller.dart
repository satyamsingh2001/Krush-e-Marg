import 'package:get/get.dart';
import 'package:krush_e_marg/app/controller/api_controller.dart';

class ToggleController extends GetxController {
  final CommunityController communityController = Get.find();

  RxList isLikedList = [].obs;

  inIt() {
    communityController.fetchComm();
    isLikedList.value =
        List.generate(communityController.commList.length, (index) => false);
    print(isLikedList);
    print("isLikedList");
  }

  void toggleLikeUnlike(int index) {
    isLikedList[index] = !isLikedList[index];
    update();
  }
}
