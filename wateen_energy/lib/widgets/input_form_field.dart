import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';
import '../utils/utility.dart';

class InputFormField extends StatelessWidget {
  final String hintText;
  final String asset;
  final TextInputType textInputType;
  final FormFieldSetter<String> onSaved;

  const InputFormField(this.asset,this.hintText, this.textInputType,{required this.onSaved})
      ;

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Strings.emptyFieldsTxt;
        }
        return null;
      },
      textAlignVertical: TextAlignVertical.center,
      obscureText: hintText.contains(Strings.pwdTxt) ? true : false,
      style:  TextStyle(fontSize: _scale.subHeading, color: Colors.black),
      textInputAction: TextInputAction.next,
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            asset,
            width: 20,
            height: 20,
            fit: BoxFit.fill,
          ),
        ),
        filled: true,
        fillColor: AppColors.inputFieldColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.inputFieldColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.inputFieldColor,
          ),
        ),
        contentPadding:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.h),
      /*  border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.3.h),
            borderSide: const BorderSide(color: Colors.grey)),*/
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black38, fontSize:_scale.subHeading),
      ),
    );
  }
}
