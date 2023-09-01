import 'package:flutter/material.dart';

import '../../../colors/colors_const.dart';

class CustomListTile extends StatefulWidget {
  final bool underline;
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const CustomListTile({Key? key,required this.title, this.underline=true, required this.onTap, required this.icon}) : super(key: key);

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: widget.onTap,
          leading: CircleAvatar(
              backgroundColor: AppColors.white30,
              radius: 20,
              child: Icon(widget.icon,color: AppColors.white50,)),
          title: Text(widget.title),
          trailing:  const Icon(Icons.arrow_forward_ios,color: AppColors.white50,),
        ),
        if(widget.underline)const Padding(
          padding: EdgeInsets.only(left: 60, right: 10),
          child: Divider(height: 1.0, thickness: 1.0),
        ),
      ],
    );
  }
}