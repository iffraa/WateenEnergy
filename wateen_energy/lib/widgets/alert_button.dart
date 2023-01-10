import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class AlertButton extends StatelessWidget {
  final String text;
  final Function onClickAction;

  const AlertButton(this.text, this.onClickAction);

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // onPrimary: Colors.black87,
          primary: AppColors.greyText,
          minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 5.h),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
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
