import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../colors/colors_const.dart';
import '../../../textstyles/textstyle_const.dart';
class InviteAndShare extends StatelessWidget {
  const InviteAndShare({Key? key}) : super(key: key);
  final String _textToCopy = 'https:/AAGYOapp.com/anmol';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      height: size.height*0.4,
      width: size.width*0.95,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.white30),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            child: Image.asset('assets/images/Above.png'),
          ),
          Expanded(
            child: Container(
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
                    height: 45,
                    width: size.width*0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white),
                    child: Center(
                      child: Text(
                        'https:/AAGYOapp.com/anmol',
                        style: AppTextStyles.kBody15SemiboldTextStyle
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: _textToCopy));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Text copied to clipboard')),
                          );
                        },
                        child: Container(
                          height: 45,
                          width: 124,
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
                      ),
                      const SizedBox(
                        width: 10,
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
    );
  }
}
