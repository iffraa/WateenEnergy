import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class RowAlertButton extends StatelessWidget {
  final String text;
  final Function onClickAction;

  const RowAlertButton(this.text, this.onClickAction);

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // onPrimary: Colors.black87,
          primary: AppColors.greyText,
          minimumSize: Size(10.h, 4.h),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(1.5.h)),
          ),
        ),
        onPressed: () {
          onClickAction();
        },
        child: Text(
          text,
          style:  TextStyle(fontSize: _scale.subHeading, color: Colors.white),
        ),
      ),
    );
  }
}
