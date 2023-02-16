import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/colour.dart';
import '../utils/strings.dart';

class TimeRadioGroup extends StatefulWidget {
  static String periodType = "";

  @override
  State<TimeRadioGroup> createState() => _TimeRadioGroupState();
}

class _TimeRadioGroupState extends State<TimeRadioGroup> {

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RadioListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.darkBlue,
                  title: Text("Daily"),
                  groupValue: TimeRadioGroup.periodType,
                  value: "Daily",
                  onChanged: (String? newValue) =>
                      setState(() => TimeRadioGroup.periodType = newValue!),
                ),
                RadioListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.darkBlue,
                  title: Text("Weekly"),
                  groupValue: TimeRadioGroup.periodType,
                  value: "Weekly",
                  onChanged: (String? newValue) =>
                      setState(() => TimeRadioGroup.periodType = newValue!),
                ),
                RadioListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.darkBlue,
                  title: Text("Monthly"),
                  groupValue: TimeRadioGroup.periodType,
                  value: "Monthly",
                  onChanged: (String? newValue) =>
                      setState(() => TimeRadioGroup.periodType = newValue!),
                ),
                RadioListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.darkBlue,
                  title: Text("Yearly"),
                  groupValue: TimeRadioGroup.periodType,
                  value: "Yearly",
                  onChanged: (String? newValue) =>
                      setState(() => TimeRadioGroup.periodType = newValue!),
                ),
              ],
            ),
          );
        });
  }
}
