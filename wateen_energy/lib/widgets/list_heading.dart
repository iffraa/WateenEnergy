import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class ListHeading extends StatelessWidget {
  final String text;

  const ListHeading(this.text);

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Padding(
      padding:  EdgeInsets.only(top: 0.5.h),
      child: Text(text,style:TextStyle(fontWeight: FontWeight.w700,fontSize: _scale.subHeading),textAlign: TextAlign.start,),
    );
    ;
  }
}
