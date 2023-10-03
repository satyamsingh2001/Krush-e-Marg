import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:krush_e_marg/app/auth/widgets/sign_signup_button_widget.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';

import '../colors/colors_const.dart';
import 'login_with_gmail.dart';
import 'otp_verification.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static String verify = "";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController countrycode = TextEditingController();
  // final AuthController authController = Get.put(AuthController());
  // final AuthControllerNew authControllerNew = Get.put(AuthControllerNew());
  final TextEditingController phoneNumberController = TextEditingController();
  late String countryCode;
  late String? phoneNumber;
  var phone = "";
  late String? _textInput;
  bool _isChecked = true;

  bool isLoading=false;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height*0.075,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Welcome to\nKrush e Marg!',
                    style: AppTextStyles.kHeading1TextStyle.copyWith(
                      color: AppColors.primary,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(
                    child: Image.asset(
                      'assets/images/privacy.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    'Login with Phone',
                    style: AppTextStyles.kBody20SemiboldTextStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'We will send you an One Time Password \n on this mobile number',
                    style: AppTextStyles.kCaption12RegularTextStyle.copyWith(
                      color: const Color.fromRGBO(100, 116, 139, 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
                    child: TextFormField(
                      validator: (value) {
                        final mobileRegex = RegExp(r'^[6-9]\d{9}$');
                        if (value == null || value.isEmpty) {
                          return 'Enter mobile number';
                        }else if (!mobileRegex.hasMatch(value)) {
                          if (value.length < 10) {
                            return 'Mobile number must be at least 10 digits';
                          } else {
                            return 'Invalid mobile number. Must start with 6,7,8,or9.';
                          }
                        }
                        return null; // Indicates the input is valid
                      },

                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      onChanged: (text) {
                        setState(() {
                          _textInput = text;
                          phone = text;
                        });
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: 'Enter mobile number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(203, 212, 225, 1),
                          ),
                        ),
                        prefixText: '+91 ',
                        prefixStyle: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white100),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.cancel_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            phoneNumberController.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                  SignInUpButtonWidget(
                    text: !isLoading? 'Get Otp':'circular',
                    onpressed: () async {
                      if (_formKey.currentState!.validate() && _isChecked) {
                        setState(() {
                          isLoading = true;
                        });
                        final String phone = phoneNumberController.text.trim();
                        if (phone.isNotEmpty) {
                          phoneNumber = '+91$phone';
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: phoneNumber!,
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent: (String verificationId, int? resendToken) {
                              WelcomeScreen.verify = verificationId;
                              if (kDebugMode) {
                                print('OTP:$verificationId');
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OtpVerification(text: _textInput!),
                                ),
                              );
                              setState(() {
                                isLoading = false;
                              });
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {},
                          );
                        }
                      }
                    },
                  ),


                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            _isChecked = !_isChecked;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _isChecked ? AppColors.primary : AppColors.white60,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          alignment: Alignment.center,
                          child: _isChecked
                              ? const Icon(
                            size: 16,
                            Icons.check,
                            color: AppColors.primary,
                          )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Text(
                        'I agree Terms and Conditions.',
                        style: AppTextStyles.kCaption12RegularTextStyle
                            .copyWith(color: const Color.fromRGBO(100, 116, 139, 1)),
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),

                  !_isChecked?Text('Please accept our terms and condition!',
                      style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.error40)):const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 1.5,
                          width: size.width * 0.25,
                          color: const Color.fromRGBO(100, 116, 139, 1),
                        ),
                        Text(
                          'Or Connect With',
                          style: AppTextStyles.kSmall10RegularTextStyle
                              .copyWith(color: AppColors.neutralLight),
                        ),
                        Container(
                          height: 1.5,
                          width: size.width * 0.25,
                          color: const Color.fromRGBO(100, 116, 139, 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LoginWithGmail(loading: _isChecked,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}