import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter_31/razorpay_flutter_31.dart';

import '../../../colors/colors_const.dart';
import '../../../textstyles/textstyle_const.dart';
class TopUp extends StatefulWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<PriceContainer?> _selectedContainer = ValueNotifier(null);

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR HERE: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  Razorpay? _razorpay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openPaymentPortal(
      ) async {
    var options = {
      'key': 'rzp_test_dJqjbQwUQ3nDjm',
      'amount': 10000,
      'name': 'krush_e_marg',
      'description': 'Payment',
      'prefill': {'contact': '9999999999', 'email': 'jhon@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.9,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColors.white40.withOpacity(0.6),
                blurRadius: 100,
                spreadRadius: 2,
                offset: const Offset(0, 70))
          ]),
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 45,
              child: TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.white10)),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add money to your wallet',
                style: AppTextStyles.kBody15RegularTextStyle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PriceContainer(
                  selectedContainer: _selectedContainer,
                  controller: _controller,
                  price: '250',
                ),
                PriceContainer(
                  selectedContainer: _selectedContainer,
                  controller: _controller,
                  price: '500',
                ),
                PriceContainer(
                  selectedContainer: _selectedContainer,
                  controller: _controller,
                  price: '1000',
                ),
                PriceContainer(
                  selectedContainer: _selectedContainer,
                  controller: _controller,
                  price: '2000',
                ),
              ],
            ),
            SizedBox(
              height: 40,
              width: size.width * 0.85,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary700),
                  onPressed: () {
                    openPaymentPortal();
                  },
                  child: Text(
                    'Top Up',
                    style: AppTextStyles.kBody15SemiboldTextStyle
                        .copyWith(color: AppColors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class PriceContainer extends StatelessWidget {
  final String price;
  final TextEditingController controller;
  final ValueNotifier<PriceContainer?> selectedContainer;

  PriceContainer({
    super.key,
    required this.price,
    required this.controller,
    required this.selectedContainer,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedContainer,
      builder: (context, value, _) {
        return GestureDetector(
          onTap: () {
            controller.text = price;

            if (value != null) {
              value.isSelected = false;
            }

            isSelected = true;
            selectedContainer.value = this;
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary700 : Colors.grey[300],
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              '₹$price',
              style: TextStyle(
                color: isSelected ? AppColors.white : Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isSelected = false;
  bool get isSelected => _isSelected;
  set isSelected(bool value) {
    _isSelected = value;
  }
}
