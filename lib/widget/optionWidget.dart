import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class optionWidget extends StatelessWidget {
  var icon;
  var backgroundColor;
  var text;
  var h;
  var w;
  var  ontap;

  optionWidget({
    required this.icon,
    required this.backgroundColor,
    required this.text,
    required this.h,
    required this.w,
    required this.ontap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              height: h,
              width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(h),
                color: backgroundColor,
              ),
              child: Icon(icon,size: 35,color: Colors.white,),
            ),
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium,
          )
        ],
      ),
    );
  }
}
