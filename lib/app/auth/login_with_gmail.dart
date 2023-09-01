import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../colors/colors_const.dart';
import '../const/api_string.dart';
import '../textstyles/textstyle_const.dart';
import '../views/bottom_nav_bar/bottom_nav_bar.dart';
import 'map_page.dart';

class LoginWithGmail extends StatefulWidget {
  final bool loading;
  const LoginWithGmail({Key? key, required this.loading}) : super(key: key);

  @override
  State<LoginWithGmail> createState() => _LoginWithGmailState();
}

class _LoginWithGmailState extends State<LoginWithGmail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 44,
      width: size.width * 0.85,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 1,
            backgroundColor: AppColors.white,
          ),
          onPressed: () async {
            if(widget.loading){
              // Sign in with Google and get the user credential
              final UserCredential userCredential = await _signInWithGoogle();
              // Access user data
              final User? user = userCredential.user;
              final String? gmail = user?.email;
              final String? name = user?.displayName;
              if (kDebugMode) {
                print('Gmail: $gmail');
              }
              if (kDebugMode) {
                print('Name: $name');
              }
              registerUser('email', gmail.toString(), name.toString());
              setState(() {
                _isLoading = true;
              });
            }
          },
          child: Center(
            child: !_isLoading?Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/google_new.png'),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Google',
                  style: AppTextStyles.kBody15RegularTextStyle
                      .copyWith(color: AppColors.neutralLight),
                )
              ],
            ):const CircularProgressIndicator(color: AppColors.primary,),
          )),
    );
  }

  registerUser(String type,String email,String? name,) async {
    final response = await http.post(
      Uri.parse("$baseurl/api/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "login_type": type,
        "email_phone": email,
        "name": name!,
      }),
    );
    var data = jsonDecode(response.body);
 if (response.statusCode == 200) {
      var userid = data["data"]["id"];
      final prefs = await SharedPreferences.getInstance();
      const key = 'userId';
      final userId = userid.toString();
      prefs.setString(key, userId);
      Get.offAll(const DashBoardScreenMain());
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const MapPage()));
      setState(() {
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select one gmail account'),
        ),
      );
    }
  }

  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> _signInWithGoogle() async {
    setState(() {
      _isLoading = true; // Start the loading state
    });
    // Trigger the Google authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    setState(() {
      _isLoading = false; // End the loading state
    });

    // Create a new credential with the token
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    setState(() {
      _isLoading = false; // End the loading state
    });

    // Sign in to Firebase with the Google credential
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    setState(() {
      _isLoading = false; // End the loading state
    });

    return userCredential;
  }
}