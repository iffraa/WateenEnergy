import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/AppScale.dart';
import '../utils/colour.dart';
import '../utils/strings.dart';
import '../utils/utility.dart';

class SearchFormField extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final FormFieldSetter<String> onSaved;

  const SearchFormField(this.hintText, this.textInputType,{required this.onSaved})
      ;

  @override
  Widget build(BuildContext context) {
    AppScale _scale = AppScale(context);

    return Padding(
      padding:  EdgeInsets.only(bottom: 1.h,left: 2.h,right: 2.h),
      child: TextFormField(
        onChanged: onSaved,
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
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.h),
            borderSide: BorderSide(
              color: AppColors.darkBlue,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(2.h),
          ),
          contentPadding:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.h),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.3.h),
              borderSide: const BorderSide(color: Colors.grey)),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize:_scale.subHeading),
        ),
      ),
    );
  }
}
