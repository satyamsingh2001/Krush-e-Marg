import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krush_e_marg/app/constwidgets/const_drop_down.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/colors/colors_const.dart';
import 'app/constwidgets/const_container.dart';
import 'app/constwidgets/const_textfield.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mrpController = TextEditingController();
  final UnitController unitController = Get.put(UnitController());
  final CategoryController categoryController = Get.put(CategoryController());

  String isSelect = "";
  String isUnit = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    unitController.fetchUnit();
    categoryController.fetchCat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Product",),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // constText("Product Name"),
                AddPhotoWidget(),
                ConstTextField(
                  hintText: 'Product Name',validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Product';
                  }
                  return null;
                },
                  maxLine: null,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ConstTextField(
                        controller: _mrpController,
                        inputType: TextInputType.number,
                        hintText: 'MRP',
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final mrp = double.tryParse(value);
                            if (mrp == null) {
                              return 'Invalid MRP format';
                            }
                          }
                          return null;
                        },
                        maxLine: null,
                      ),
                    ),
                    SizedBox(width: Get.width * 0.01),
                    Expanded(
                      child: ConstTextField(
                        inputType: TextInputType.number,
                        hintText: 'Sell Price',
                        validator: (value) {
                          final mrpValue = double.tryParse(_mrpController.text); // Step 3
                          if (mrpValue != null && value != null && value.isNotEmpty) {
                            final sellPrice = double.tryParse(value);
                            if (sellPrice == null) {
                              return 'Invalid Sell Price format';
                            }
                            if (mrpValue<sellPrice) {
                              return 'It must be equal/less than MRP';
                            }
                          }
                          return null;
                        },
                        maxLine: null,
                      ),
                    ),
                  ],
                ),
                ConstantDropdown(
                  options:categoryController.catList,

                  // const [ "Tea", " Onion", "Rajasthan Onion", "MP Onion"],
                  onChanged: (value) {
                    setState(() {
                      isSelect = value;
                    });
                  },
                  iconColor: AppColors.white80,
                  dropdownColor: AppColors.white,
                  textColor: AppColors.white100, hint: 'Select Category',),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ConstTextField(
                        inputType: TextInputType.number,
                        hintText: 'Quantity',validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Please enter Quantity';
                        }
                        return null;
                      },
                        maxLine: null,
                      ),
                    ),
                    SizedBox(width: Get.width*0.01,),
                    Expanded(
                      child: ConstantDropdown(
                        options:unitController.unitList
                        ,
                        // const [ "kg", " cm", "lt", "Qt"],
                        onChanged: (value) {
                          setState(() {
                            isUnit = value;
                          });
                        },
                        iconColor: AppColors.white80,
                        dropdownColor: AppColors.white,
                        textColor: AppColors.white100, hint: 'Select Unit',),



                    )


                  ],
                ),

                ConstTextField(
                 inputType: TextInputType.number,
                  hintText: 'Stock',validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Stock';
                  }
                  return null;
                },

                  maxLine: null,
                ),
                const SizedBox(height: 10,),
                Center(
                  child: InkWell(
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                      }
                    },
                    child: ConstantContainer(
                      color: AppColors.primary,
                      radiusBorder: 20,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 8),
                        child: Text("Add Product",style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

}


class AddPhotoWidget extends StatefulWidget {
  const AddPhotoWidget({super.key});

  @override
  _AddPhotoWidgetState createState() => _AddPhotoWidgetState();
}

class _AddPhotoWidgetState extends State<AddPhotoWidget> {
  final List<File> _selectedPhotos = [];

  Future<void> _selectPhoto() async {
    final pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _selectedPhotos.add(file);
      });
    }
  }
  void _clearPhoto(int index) {
    setState(() {
      _selectedPhotos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              if (_selectedPhotos.isEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                      onTap: () {
                        _selectPhoto();
                      },
                      child: ConstantContainer(
                        height: 100,
                        width: 80,
                        radiusBorder: 5,
                        borderColor: AppColors.white50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.primary,
                              child: Icon(
                                Icons.add,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              "Add photos",
                              style: AppTextStyles.kBody15RegularTextStyle
                                  .copyWith(color: AppColors.white70),
                            )
                          ],
                        ),
                      )),
                ),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 8.0,
                runSpacing: 8.0,
                children: _selectedPhotos.map((file) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: size.width/4,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(file),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 5,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xff554f51),
                          child: IconButton(
                            icon: Icon(
                              Icons.clear,
                              size: 10,
                            ),
                            onPressed: () {
                              _clearPhoto(_selectedPhotos.indexOf(file));
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



class UnitController extends GetxController {
  List unitList = [];

  Future<void> fetchUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    final id = prefs.getString("userId");

    String unitUrl = "https://admin.billpe.co.in/api/vendor/unit-list";
    final response = await http.get(Uri.parse(unitUrl),
    //     headers: {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   // 'Authorization': 'Bearer $brearToken',
    // }
    );

    var data = jsonDecode(response.body);
      var satya = data['data'];
    if (response.statusCode == 200) {
      for(int i =0;i<satya.length;i++){
        unitList.add('${satya[i]['name']}');
      }
      // print(unitList);
      // print("SatyamSingh");
      // print("sssssssssssssssssssssssssssssssssssssss");
      update();
    } else {
      // print("dat not found");
      // print("Metro");
      throw Exception('Failed to load categories');
    }
  }

}
class CategoryController extends GetxController {
  List catList = [];

  Future<void> fetchCat() async {
    final prefs = await SharedPreferences.getInstance();
    final brearToken = prefs.getString("barrierToken");
    final id = prefs.getString("userId");

    String catUrl = "https://admin.billpe.co.in/api/vendor/categoryViaStore/8";
    final response = await http.get(Uri.parse(catUrl),
    //     headers: {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   // 'Authorization': 'Bearer $brearToken',
    // }
    );

    var data = jsonDecode(response.body);
      var satya = data['data'];
    if (response.statusCode == 200) {
      for(int i =0;i<satya.length;i++){
        catList.add('${satya[i]['name']}');
      }
      print(catList);
      print("SatyamSingh");
      // print("sssssssssssssssssssssssssssssssssssssss");
      update();
    } else {
      // print("dat not found");
      // print("Metro");
      throw Exception('Failed to load categories');
    }
  }

}
