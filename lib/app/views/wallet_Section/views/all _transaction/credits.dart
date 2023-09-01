import 'package:flutter/material.dart';

import '../../../../colors/colors_const.dart';
import '../../../../textstyles/textstyle_const.dart';
class CreditsTransaction extends StatefulWidget {
  const CreditsTransaction({Key? key}) : super(key: key);

  @override
  State<CreditsTransaction> createState() => _CreditsTransactionState();
}

class _CreditsTransactionState extends State<CreditsTransaction> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                leading:
                Image.asset('assets/icons/success.png'),
                title: const Text(
                  'Cash Deposit Success',
                  style:
                  AppTextStyles.kCaption12RegularTextStyle,
                ),
                subtitle: Row(
                  children: const [
                    Text('25/01/23'),
                    SizedBox(
                      width: 10,
                    ),
                    Text('09:30pm')
                  ],
                ),
                trailing: const Text(
                  '₹500',
                  style: AppTextStyles.kBody15SemiboldTextStyle,
                ),
              ),
              const Divider(
                color: AppColors.white30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
