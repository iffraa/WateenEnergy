import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class NavButton extends StatelessWidget {
  final String text;
  final Function onClickAction;

  const NavButton(this.text, this.onClickAction)
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
            minimumSize: Size(MediaQuery
                .of(context)
                .size
                .width, 6.h),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            side: BorderSide(width:1, color:AppColors.yellow), //border width and color
            shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2.h)),
            ),
          ),
          onPressed: () {
            onClickAction();
          },
          child: Text(text, style:  TextStyle(
              fontSize: _scale.formButton,
              color: Colors.white),),
        )
    );
  }

}
