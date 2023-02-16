import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class FormButton extends StatelessWidget {
  final String text;
  final Function onClickAction;

  const FormButton(this.text, this.onClickAction)
  ;

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Align(
      alignment: Alignment.topRight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // onPrimary: Colors.black87,
           primary: AppColors.darkBlue,
          maximumSize: Size(14.h, 30.h),
          //padding:  EdgeInsets.symmetric(horizontal: 4.h),
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3.h)),
          ),
        ),
        onPressed: () {
          onClickAction();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(text, style:  TextStyle(fontWeight: FontWeight.w500,
                  fontSize: _scale.ssTxt,
                  color: Colors.white),),
            ),
            SizedBox(width: 1.h,),
            Icon(Icons.arrow_forward_ios,size: 1.7.h,)
          ],
        ),
      ),
    );
  }

}
