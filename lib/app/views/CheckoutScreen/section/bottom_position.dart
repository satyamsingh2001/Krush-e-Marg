import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:flutter/material.dart';

import '../screens/change_address.dart';
class BottomPosition extends StatefulWidget {
  final String? grandTotal;
  const BottomPosition({Key? key, this.grandTotal}) : super(key: key);

  @override
  State<BottomPosition> createState() => _BottomPositionState();
}

class _BottomPositionState extends State<BottomPosition> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 100,
      width: size.width,
      decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
              top: BorderSide(
                  color: AppColors.white30
              )
          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('HOME - ',style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.white100),),
                Text("${'arjh tech labs noida sector H asdfasdfka asdfiasdhfas asidfhsdjfa afuqertb'.substring(0,35)}...",style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: AppColors.white80),),
                const Spacer(),
                const Icon(Icons.location_on,color: AppColors.primary,size: 14,),
                GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                        backgroundColor:Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return const ChangeAddress();
                        },
                      );
                    },
                    child: Text('CHANGE ADDRESS',style: AppTextStyles.kSmall10SemiboldTextStyle.copyWith(color: AppColors.primary),)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('To Pay',style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.primary),),
                    Text('₹${widget.grandTotal}',style: AppTextStyles.kBody20SemiboldTextStyle,),
                  ],
                ),
                ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10), backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Add Address at Next Step'),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
