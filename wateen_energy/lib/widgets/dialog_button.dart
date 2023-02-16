import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class DialogButton extends StatelessWidget {
  final String text;
  final Function onClickAction;

  const DialogButton(this.text, this.onClickAction)
  ;

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);
    return Padding(
        padding:  EdgeInsets.symmetric(vertical: 2.h),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // onPrimary: Colors.black87,
             primary: AppColors.darkBlue,
            minimumSize: Size(6.h, 6.h),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            side: BorderSide(width:1, color:AppColors.greyBg), //border width and color
            shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2.h)),
            ),
          ),
          onPressed: () {
            onClickAction();
          },
          child: Text(
            textAlign: TextAlign.center,
            text, style:  TextStyle(
              fontSize: _scale.navButton,
              color: Colors.white),),
        )
    );
  }

}
