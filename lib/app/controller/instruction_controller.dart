import 'package:get/get.dart';

class InstructionController extends GetxController{

  final List<String> title = ["No Contact \n Delivery","Beware of\n Pets",'Do Not Ring\n The Bell'];
  final List<String> img = ["assets/images/nocontact.png","assets/images/dog.png","assets/images/donotring.png"];
  List<bool> selectedItems = List<bool>.generate(3, (index) => false);

  RxList selectedInst = [].obs;
  void toggleSelectedString(String selectedString) {
      if (selectedInst.contains(selectedString)) {
        selectedInst.remove(selectedString);
      } else {
        selectedInst.add(selectedString);
      }
      update();
  }
}