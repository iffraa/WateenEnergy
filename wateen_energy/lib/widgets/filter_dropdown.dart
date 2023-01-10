import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/utils/colour.dart';

class FilterDropdown extends StatefulWidget {

  List<String> list;
  final Function(String) onClickAction;

   FilterDropdown(this.list , this.onClickAction,{super.key});

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(left: 2.h,right: 2.h),
      decoration: BoxDecoration(
         color: AppColors.greyDropDownColor,
          borderRadius: BorderRadius.all(Radius.circular(1.h))),
      width: MediaQuery.of(context).size.width,
      height: 3.5.h,
      padding: EdgeInsets.only(left: 1.h,right: 1.h),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            isExpanded: true,
        value: dropdownValue,
        //  value: "Karachi",//widget.list.first,
          hint: new Text("Select",style: TextStyle(color: Colors.black, fontSize: 15.px),),
          icon:  Icon(Icons.arrow_downward),
          iconSize: 2.h,
          elevation: 16,
          style:  TextStyle(color: Colors.black,fontSize: 15.px),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
            widget.onClickAction(dropdownValue!);
          },
          items: widget.list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
