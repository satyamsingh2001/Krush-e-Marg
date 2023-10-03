import 'dart:convert';
import 'package:krush_e_marg/app/views/CheckoutScreen/views/checkout_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../colors/colors_const.dart';
import '../../../const/api_string.dart';
import '../../../textstyles/textstyle_const.dart';

class AddMoreDetailsPage extends StatefulWidget {
  final String mapAddress;
  final String sendlat;
  final String sendlong;
  const AddMoreDetailsPage({Key? key, required this.mapAddress, required this.sendlat, required this.sendlong}) : super(key: key);

  @override
  State<AddMoreDetailsPage> createState() => _AddMoreDetailsPageState();
}

class _AddMoreDetailsPageState extends State<AddMoreDetailsPage> {
  final TextEditingController houseno = TextEditingController();
  final TextEditingController blockno = TextEditingController();
  final TextEditingController landmark = TextEditingController();
  final TextEditingController label = TextEditingController();
  bool _selected = false;
  String labelValue="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20,),
              Text(
                "Fill Other Details",
                style: AppTextStyles.kBody17SemiboldTextStyle
                    .copyWith(color: AppColors.white80),
              ),
              const SizedBox(height: 20,),
              ConstantTextFormField(
                controller: houseno,
                hintText: "House no / colony name",
                label: "House no / colony name",
              ),
              const SizedBox(height: 15,),
              ConstantTextFormField(
                controller: blockno,
                hintText: "Blockno / floorno",
                label: "BlockNo / floorNo(Optional)",
              ),
              const SizedBox(height: 15,),
              ConstantTextFormField(
                controller: landmark,
                hintText: "Nearby landmark",
                label: "Nearby Landmark(Optional)",
              ),
              const SizedBox(height: 10,),
              const Align(
                alignment: Alignment.centerLeft,
                  child: Text('Add address Label',style: AppTextStyles.kBody15SemiboldTextStyle,)),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        labelValue = 'HOME';
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: labelValue == 'HOME' ? AppColors.error20 : AppColors.white20,
                        borderRadius: BorderRadius.circular(20),
                        border: labelValue == 'HOME' ? null : Border.all(color: AppColors.white50),
                      ),
                      child: Text(
                        'HOME',
                        style: AppTextStyles.kBody15RegularTextStyle.copyWith(
                          color: labelValue == 'HOME' ? AppColors.white : AppColors.white70,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        labelValue = 'OFFICE';
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: labelValue == 'OFFICE' ? AppColors.error20 : AppColors.white20,
                        borderRadius: BorderRadius.circular(20),
                        border: labelValue == 'OFFICE' ? null : Border.all(color: AppColors.white50),
                      ),
                      child: Text(
                        'OFFICE',
                        style: AppTextStyles.kBody15RegularTextStyle.copyWith(
                          color: labelValue == 'OFFICE' ? AppColors.white : AppColors.white70,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        labelValue = 'OTHER';
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: labelValue == 'OTHER' ? AppColors.error20 : AppColors.white20,
                        borderRadius: BorderRadius.circular(20),
                        border: labelValue == 'OTHER' ? null : Border.all(color: AppColors.white50),
                      ),
                      child: Text(
                        'OTHER',
                        style: AppTextStyles.kBody15RegularTextStyle.copyWith(
                          color: labelValue == 'OTHER' ? AppColors.white : AppColors.white70,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              if (labelValue == 'OTHER')
                ConstantTextFormField(
                  controller: label,
                  hintText: "Add Other Label",
                  label: "Add Other Label",
                )
              else
                Container(),

              const SizedBox(height: 10,),
              SizedBox(
                height: 45,
                width: size.width * 0.85,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary700,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7))),
                    onPressed: () {
                      List<String> strings = [widget.sendlat,widget.sendlong];
                      saveStrings(strings);
                      addAddress(label.text,houseno.text,blockno.text,widget.mapAddress.toString(),landmark.text);
                    },
                    child: Text(
                      "Continue",
                      style: AppTextStyles.kBody15RegularTextStyle
                          .copyWith(color: Colors.white),
                    )),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveStrings(List<String> strings) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('strings', strings);
  }

  addAddress(
      String? label,
      String? houseNo,
      String? floorNo,
      String map,
      String? landmark,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final brearToken = prefs.getString("barrierToken");

    final response = await http.post(
      Uri.parse("$baseurl/api/user/add/address/$userid"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $brearToken',
      },
      body: jsonEncode(<String, String>{
        "label": label!,
        "name": houseNo!,
        "house_floor_no": floorNo!,
        "map": map,
        "landmark": landmark!,
      }),
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
      Get.off(const CheckoutScreeen());
    } else {
      if (kDebugMode) {
        print('address not saved');
      }
    }
  }
}

class ConstantTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;

  const ConstantTextFormField({
    Key? key,
    this.controller,
    this.label,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        cursorColor: AppColors.primary,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelStyle: const TextStyle(color: AppColors.white70),
          hintStyle: const TextStyle(color: AppColors.white50),
          labelText: label,
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white50),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
