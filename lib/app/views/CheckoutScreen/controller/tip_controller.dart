import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TipController extends GetxController{
  RxInt customTip = 0.obs;
  TextEditingController textEditingController = TextEditingController();
  int selectedTipIndex = -1; // Index of the selected preset tip, -1 means none selected
  bool showCustomTipField = false;

  void selectPresetTip(int index, int amount) {
      selectedTipIndex = index;
      customTip.value = amount;
      showCustomTipField = false; // Hide custom tip field when a preset tip is selected
    update();
  }

  void showCustomTip() {
      selectedTipIndex = -1; // Reset selected preset tip
      showCustomTipField = true; // Show custom tip field
    update();
  }

  void nonSelectedTip() {
      selectedTipIndex = -1; // Reset selected preset tip
      customTip.value = 0;
      update();
  }
  void setTipValue(){
      showCustomTipField = !showCustomTipField;
      customTip = int.parse(textEditingController.text).obs;
      update();
  }
  void cancelTipValue(){
    textEditingController.clear();
    customTip.value = 0;
    update();
  }
}