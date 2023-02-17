import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/colour.dart';
import '../utils/strings.dart';

class FormatRadioGroup extends StatefulWidget {
  static String formatType = "";

  @override
  State<FormatRadioGroup> createState() => _FormatRadioGroupState();
}

class _FormatRadioGroupState extends State<FormatRadioGroup> {

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.darkBlue,
                  title: Text("PDF"),
                  groupValue: FormatRadioGroup.formatType,
                  value: "PDF",
                  onChanged: (String? newValue) =>
                      setState(() => FormatRadioGroup.formatType = newValue!),
                ),
              ),
              Expanded(
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.darkBlue,
                  title: Text("CSV"),
                  groupValue: FormatRadioGroup.formatType,
                  value: "CSV",
                  onChanged: (String? newValue) =>
                      setState(() => FormatRadioGroup.formatType = newValue!),
                ),
              ),
            ],
          );
        });
  }
}
