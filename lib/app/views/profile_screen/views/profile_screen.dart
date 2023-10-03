import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth/features/firebase_service.dart';
import '../../../auth/welcomeScreen.dart';
import '../../../colors/colors_const.dart';
import '../../../const/api_string.dart';
import '../../bottom_nav_bar/bottom_nav_bar.dart';
import '../../statics_pages/about_us.dart';
import '../../statics_pages/contact_us.dart';
import '../../statics_pages/loyality_points.dart';
import '../../statics_pages/privacy_policy.dart';
import '../../statics_pages/refund_policy.dart';
import '../../statics_pages/terms_and_conditions.dart';
import '../widgets/custom_list_tile.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, e});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    viewDetails();
    setState(() {
    });
  }

  var map;
  Future viewDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.post(
      Uri.parse("updateProfile+$userid"),
    );
    var data = jsonDecode(response.body);

      if (data['status']==1) {
        setState(() {
          map = data['data'];
        });
    }
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    String phone = map!=null?map["phone"].toString():"update mobile";
    String duplicateGmail = '$phone@gmail.com';
    String originalGmail = map != null ? map['email'].toString():'' ;
     return SafeArea(
       child: Scaffold(
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                       // Get.offUntil(DashBoardScreenMain() as Route, (route) => false);
                       Get.offAll(const DashBoardScreenMain());
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: size.height * 0.13,
                            decoration: BoxDecoration(
                                // color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.white30,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                 Text(
                                    map == null ? 'Your name' : map['f_name']==""?"${map['phone']}":map['f_name']+" "+map["l_name"],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Mo - $phone',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    map != null ? originalGmail!=duplicateGmail? originalGmail :'Kindly update your profile':"Loading",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(const EditProfile());
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'edit profile',
                                          style: AppTextStyles
                                              .kSmall10SemiboldTextStyle
                                              .copyWith(
                                                  color: AppColors.primary700),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                          size:20,
                                          Icons.edit_note,
                                          color: AppColors.primary700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: size.width*0.05,
                      bottom: size.height*0.05,
                      child: CircleAvatar(
                        backgroundColor: AppColors.error20,
                          radius: 50,
                          backgroundImage: NetworkImage(map==null?"":map["image_url"].toString()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                //please don't erase below code without check

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     ProfileOptionWidgets(
                //         isPressed: () {
                //           Get.to(const LikesScreen());
                //         },
                //         image: 'assets/icons/newheart.png',
                //         title: 'Likes'),
                //     ProfileOptionWidgets(
                //         isPressed: () {
                //           Get.to(const WalletPageScreen());
                //         },
                //         image: 'assets/icons/wallet.png',
                //         title: 'Wallet'),
                //     ProfileOptionWidgets(
                //         isPressed: () {},
                //         image: 'assets/icons/ccard.png',
                //         title: 'Payments'),
                //   ],
                // ),
                // const SizedBox(
                //   height: 20,
                // ),

                Container(
                  height: size.height * 0.38,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white30),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Image.asset('assets/images/Above.png'),
                      Expanded(
                        child: Container(
                          // height: size.height * 0.265,
                          decoration: const BoxDecoration(
                              color: AppColors.primary700,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                'Invite friends and get 30% off\n on your next order!',
                                style: AppTextStyles.kBody17SemiboldTextStyle
                                    .copyWith(color: AppColors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: size.width * 0.8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.white),
                                child: Text(
                                  'https:/AAGYOapp.com/anmol',
                                  style: AppTextStyles.kBody15SemiboldTextStyle
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 45,
                                    width: size.width * 0.35,
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.copy,
                                          color: AppColors.primary600,
                                        ),
                                        Text(
                                          'Copy Link',
                                          style: AppTextStyles
                                              .kCaption12SemiboldTextStyle
                                              .copyWith(color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.share,
                                            color: AppColors.primary600,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    // height: 280,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.white30,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'About Orders',
                              style: AppTextStyles.kCaption12SemiboldTextStyle,
                            ),
                          ),
                        ),
                   CustomListTile(title: 'Your Orders', onTap: (){
                     Get.to(const DashBoardScreenMain(currentIndex: 3,));
                   }, icon: Icons.library_books),
                     CustomListTile(title: 'Favourite Orders', onTap: (){}, icon: Icons.favorite_rounded),
                     CustomListTile(title: 'Address Book', onTap: (){}, icon: Icons.contact_page),
                        CustomListTile(title: 'Online Ordering Help', onTap: (){}, icon: Icons.support_agent_rounded,underline: false,)
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 160,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.white30,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Credits & Gift Cards',
                            style: AppTextStyles.kCaption12SemiboldTextStyle,
                          ),
                        ),
                      ),
                  CustomListTile(title: 'Loyalty Points', onTap: (){
                    Get.to(const LoyalityPoints());
                  }, icon: Icons.local_activity_outlined),
                      CustomListTile(title: 'Gift card', onTap: (){}, icon: Icons.card_giftcard_rounded,underline: false,)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    // height: 325,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.white30,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Rate & Support',
                              style: AppTextStyles.kCaption12SemiboldTextStyle,
                            ),
                          ),
                        ),
                    CustomListTile(title: 'Send Feedback', onTap: (){}, icon: Icons.edit_note),
                    CustomListTile(title: 'Customer Support & FAQ', onTap: (){}, icon: Icons.support_agent_rounded),
                    CustomListTile(title: 'Report a saftey emergency', onTap: (){}, icon: Icons.report_problem_outlined),
                    CustomListTile(title: 'Suggest products', onTap: (){}, icon: Icons.production_quantity_limits), CustomListTile(title: 'Rate Us', onTap: (){}, icon: Icons.star_rate,underline: false,)
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    // height: 330,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.white30,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'More',
                              style: AppTextStyles.kCaption12SemiboldTextStyle,
                            ),
                          ),
                        ),

                     CustomListTile(icon: Icons.info_rounded, title: 'About Us', onTap: (){
                       Get.to(const AboutUs());
                     }),
                       CustomListTile(title: 'Contact Us', onTap: (){
                         Get.to(const ContactUs());
                       }, icon: Icons.call),
                       CustomListTile(icon: Icons.policy, title: 'Privacy Policy', onTap: (){
                         Get.to(const PrivacyPolicy());
                       }),
                      CustomListTile(icon: Icons.real_estate_agent, title: 'Refund Policy', onTap: (){
                        Get.to(const RefundPolicy());
                      }),
                        CustomListTile(icon: Icons.list_alt_rounded, title: 'Terms and Conditions', onTap: () {
                          Get.to(const TermsandConditions());
                        },),
                        CustomListTile(icon: Icons.local_shipping_outlined,
                          title: 'Shipping Policy',
                          onTap: () {  },
                          underline: false,)
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      FirebaseServices().signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                          (route) => false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Icons.exit_to_app),
                        Text(
                          'Logout',
                          style: AppTextStyles.kCaption12SemiboldTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
     );
  }
}