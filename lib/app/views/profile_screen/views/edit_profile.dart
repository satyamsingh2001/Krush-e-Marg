import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../colors/colors_const.dart';
import '../../../const/api_string.dart';
import '../../../textstyles/textstyle_const.dart';
import '../../bottom_nav_bar/bottom_nav_bar.dart';
import '../widgets/custom_text_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final TextEditingController username = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController emailId = TextEditingController();
  final dateController = TextEditingController();

  List<String> gender = ["Male", "Female"];
  String? selectedGender;
  selectGender(String gender) {
    selectedGender = gender;
    // notifyListeners();
  }

  File? _image;
  final picker = ImagePicker();
  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  Future<void> uploadImageToServer(String? name,String? email,String? phoneNo,String? dob,) async {
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");

    final url = "updateProfile+$userid"; // Replace with your server endpoint URL

    // Create multipart request for POST
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Attach the image to the request
    // request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
    if (_image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
    }
    // Add additional fields
    request.fields['name'] = name!;
    request.fields['email'] = email!;
    request.fields['phone'] = phoneNo!;
    request.fields['dob'] = dob!;
    if(selectedGender!=null){
    request.fields['gender'] = selectedGender!;}
      // Send the request
    var response = await request.send();
    // Decode the response data
    var responseData = await response.stream.bytesToString();
    // Assuming the server sends a JSON response, you can use jsonDecode to parse it
    var decodedData = jsonDecode(responseData);
    // print(decodedData['status']);

    if (decodedData['status']==1) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const DashBoardScreenMain(currentIndex: 4,)), (route) => false);
      Get.snackbar(
        'Message : ', // Title
        'Profile Updated Successfully...', // Message
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),// Snack Position
        duration: const Duration(seconds: 3), // Duration to display
        backgroundColor: Colors.greenAccent, // Snackbar background color
        colorText: Colors.black, // Text color
      );
      setState(() {
        isLoading=!isLoading;
      });
    } else {
      Get.snackbar(
        'Error', // Title
        'Something went wrong...', // Message
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),// Snack Position
        duration: const Duration(seconds: 3), // Duration to display
        backgroundColor: Colors.redAccent, // Snackbar background color
        colorText: Colors.white, // Text color
      );
      setState(() {
      isLoading=!isLoading;
      });
      // print("Image upload failed with status: ${response.statusCode}");
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: AppTextStyles.kBody17SemiboldTextStyle
              .copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: _image == null
                            ? const CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.black12,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Upload Profile',
                                  style: TextStyle(
                                      color: AppColors.primary, fontSize: 12),
                                ))
                            : CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(_image!),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: 150,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            getImage(ImageSource.camera);
                                            Navigator.pop(context);
                                          },
                                          leading: const Icon(
                                            Icons.add_a_photo,
                                            color: AppColors.primary,
                                          ),
                                          title: const Text('Take Photo'),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            getImage(ImageSource.gallery);
                                            Navigator.pop(context);
                                          },
                                          leading: const Icon(
                                            Icons.photo_library,
                                            color: AppColors.primary,
                                          ),
                                          title:
                                              const Text('Select From Gallery'),
                                        )
                                      ],
                                    ));
                              },
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(17),
                                border: Border.all(
                                    color: AppColors.primary700, width: 1.5)),
                            child: const Icon(
                              Icons.edit,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: username,
                keyboardType: TextInputType.name,
                title: 'Name  ',
                hintText: 'Enter your name',
              ),
              CustomTextField(
                controller: phoneNo,
                keyboardType: TextInputType.number,
                maxLength: 10,
                title: 'Phone Number',
                hintText: 'Add your phone number',
              ),
              CustomTextField(
                controller: emailId,
                keyboardType: TextInputType.emailAddress,
                title: 'Email Id',
                hintText: 'Enter your email',
              ),
              CustomTextField(
                keyboardType: TextInputType.datetime,
                // readonly: true,
                controller: dateController,
                title: 'Date of Birth  ',
                hintText: 'dd/mm/yy',
                suffix: GestureDetector(
                    onTap: () async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime(
                            2010,
                          ),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2010));
                      if (date != null) {
                        dateController.text =
                            DateFormat('dd/MM/yyyy').format(date);
                        if (kDebugMode) {
                          print(date);
                        }
                      }
                    },
                    child: const Icon(Icons.calendar_today_outlined,color: AppColors.primary,)),),

              const Text(
                'Gender  ',
              ),
              SizedBox(
                height: 65,
                child: DropdownButton<String>(
                  value: selectedGender,
                  itemHeight: 50,
                  isExpanded: true,
                  hint: const Text("select gender"),
                  icon: const Icon(CupertinoIcons.chevron_down),
                  iconSize: 20,
                  style: const TextStyle(color: Colors.black),
                  underline: const Divider(
                    color: AppColors.white40,
                    thickness: 1,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      selectGender(newValue!);
                    });
                  },
                  items: (gender).map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(
                height: 45,
                width: size.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary700),
                    onPressed: () {
                      if(username.text.isEmpty && emailId.text.isEmpty && phoneNo.text.isEmpty && dateController.text.isEmpty){
                        Get.back();
                        Get.snackbar(
                          'Message', // Title
                          'NO Changes...', // Message
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),// Snack Position
                          duration: const Duration(seconds: 3), // Duration to display
                          backgroundColor: Colors.blueAccent, // Snackbar background color
                          colorText: Colors.white, // Text color
                        );
                      }else{
                      uploadImageToServer(username.text,emailId.text,phoneNo.text,dateController.text);
                      setState(() {
                        isLoading = !isLoading;
                      });
                    }},
                    child: !isLoading?const CircularProgressIndicator(color: AppColors.white,):Text(
                      'Update Profile',
                      style: AppTextStyles.kBody15SemiboldTextStyle
                          .copyWith(color: AppColors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
  bool isLoading = true;
}

