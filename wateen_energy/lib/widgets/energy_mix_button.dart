import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';

class EnergyMixButton extends StatefulWidget {
  final String text;
  final Function onClickAction;

  EnergyMixButton(this.text, this.onClickAction);

  @override
  State<EnergyMixButton> createState() => _EnergyMixButtonState();
}

class _EnergyMixButtonState extends State<EnergyMixButton> {
  bool changeColor = false;

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // onPrimary: Colors.black87,
          primary:AppColors.lightBlue,// changeColor ? Colors.white : AppColors.lightBlue,
          minimumSize: Size(9.h, 5.h),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.6.h)),
          ),
        ),
        onPressed: () {
        /*  setState(() {
            changeColor = !changeColor;
          });*/
          widget.onClickAction();
        },
        child: Text(
          widget.text,
          style: TextStyle(fontSize: _scale.subHeading, color: Colors.white),
        ),
      ),
    );
  }
}
