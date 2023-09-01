import 'dart:async';
import 'dart:convert';
import 'package:krush_e_marg/app/auth/welcomeScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:krush_e_marg/app/auth/widgets/sign_signup_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/api_string.dart';
import '../views/bottom_nav_bar/bottom_nav_bar.dart';

class OtpVerification extends StatefulWidget {
  final String text;
  const OtpVerification({super.key, required this.text});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  int _secondsRemaining = 60;
  Future<void> resendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.text,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        // Update the verification ID in the state
        WelcomeScreen.verify = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 30, color: AppColors.primary, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromRGBO(203, 212, 225, 1)),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    //   border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
    //   borderRadius: BorderRadius.circular(8),
    // );
    //
    // final submittedPinTheme = defaultPinTheme.copyWith(
    //   decoration: defaultPinTheme.decoration?.copyWith(
    //     color: const Color.fromRGBO(234, 239, 243, 1),
    //   ),
    // );

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 140,
            ),
            Align(
                alignment: Alignment.center,
                child:
                    SizedBox(child: Image.asset('assets/images/enterotp.png'))),
            const SizedBox(
              height: 32,
            ),
            const Text(
              textAlign: TextAlign.center,
              'OTP Verification',
              style: AppTextStyles.kBody20SemiboldTextStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              textAlign: TextAlign.center,
              'Please enter OTP recieved on',
              style: AppTextStyles.kCaption12RegularTextStyle
                  .copyWith(color: AppColors.neutralLight),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              textAlign: TextAlign.center,
              widget.text,
              style: AppTextStyles.kBody15SemiboldTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Pinput(
                length: 6,
                onChanged: (text) {
                  code = text;
                },
                defaultPinTheme: defaultPinTheme,
              ),
            ),
            SignInUpButtonWidget(
                text: !_loading?'Verify & Proceed':'circular',
                onpressed: () async {
                  setState(() {
                    _loading = true;
                  });
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: WelcomeScreen.verify,
                            smsCode: code);
                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);
                    registerUser('phone', widget.text.toString(),"");
                      _loading = false;
                    setState(() {
                    });
                  } catch (e) {
                    if (kDebugMode) {
                      print(e);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Wrong otp'),
                      ),
                    );
                  }
                }),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  resendOTP();
                },
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'Didn’t you receive any code?',
                    style: AppTextStyles.kCaption12SemiboldTextStyle
                        .copyWith(color: AppColors.neutralLight, fontSize: 12),
                  ),
                  const WidgetSpan(
                      child: SizedBox(
                    width: 10,
                  )),
                  TextSpan(
                      text: 'Resend Code',
                      style: AppTextStyles.kSmall10RegularTextStyle
                          .copyWith(color: AppColors.primary700, fontSize: 12)),
                  TextSpan(
                    text: ' ($_secondsRemaining Sec)',
                    style: AppTextStyles.kCaption12SemiboldTextStyle
                        .copyWith(color: AppColors.neutralLight, fontSize: 12),
                  )
                ])),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 1.5,
                    width: 140,
                    color: const Color.fromRGBO(100, 116, 139, 1),
                  ),
                  Text(
                    'Or',
                    style: AppTextStyles.kSmall10RegularTextStyle
                        .copyWith(color: AppColors.neutralLight),
                  ),
                  Container(
                    height: 1.5,
                    width: 140,
                    color: const Color.fromRGBO(100, 116, 139, 1),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Get OTP on Call',
                  style: AppTextStyles.kBody15SemiboldTextStyle
                      .copyWith(color: AppColors.primary700),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(Icons.phone)
              ],
            ),
          ],
        ),
      )),
    );
  }
  registerUser(String type,String email,String? name) async {
    final response = await http.post(
      Uri.parse("$baseurl/api/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "login_type": type,
        "email_phone": email,
        "name": name!
      }),
    );
    var data = jsonDecode(response.body);
    var userid = data["data"]["id"];
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      const key = 'userId';
      final userId = userid.toString();
      prefs.setString(key, userId);
      Get.offAll(const DashBoardScreenMain());
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => const MapPage()),
      //         (route) => false);
    } else {
      // print('wrong otp');
    }
  }
}
