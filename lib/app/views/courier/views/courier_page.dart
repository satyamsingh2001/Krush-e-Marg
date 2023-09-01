import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:flutter/material.dart';

class CourierScreen extends StatefulWidget {
  const CourierScreen({super.key});

  @override
  State<CourierScreen> createState() => _CourierScreenState();
}

class _CourierScreenState extends State<CourierScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.07,
          ),
          SizedBox(
            height: size.height * 0.24,
            width: size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              elevation: 3,
              child: ClipRRect(
               borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQoMNeKucHmYCiHnDrOaZ0MtxkRZpEBpzqww&usqp=CAU',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Quick Action',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CustomCard(
                img: 'assets/courierimages/sendpackage.png',
                title: 'Send Package',
              ),
              CustomCard(
                img: 'assets/courierimages/ratecaculator.png',
                title: 'Shipping Rate Calculator',
              ),
              CustomCard(
                img: 'assets/courierimages/support.png',
                title: 'Send Package',
              ),
              CustomCard(
                img: 'assets/courierimages/orderlist.png',
                title: 'Send Package',
              ),
            ],
          ),
          const SizedBox(height: 20,),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ongoing Orders:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
            const SizedBox(height: 10,),
            SizedBox(
                height: size.height*0.18,
                width: size.width*0.7,
                child: Image.asset('assets/courierimages/ongoingorder.png',)),
          const SizedBox(height: 20,),
          const Text(textAlign: TextAlign.center,"Looks like you don't have any ongoing projects at the moment. Let's start a nwe one!"),
          TextButton(onPressed: (){},
              child: const Text('Add Address',style: TextStyle(color: AppColors.primary),)),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String img;
  final String title;
  const CustomCard({Key? key, required this.img, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: size.height * 0.1,
          width: size.width * 0.23,
          child: Card(
            elevation: 2,
            child: Image.asset(img,fit: BoxFit.fill,),
          ),
        ),
        const SizedBox(height: 5,),
        SizedBox(
            width: size.width * 0.23,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ))
      ],
    );
  }
}
