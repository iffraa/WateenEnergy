import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DropdownSpinner extends StatefulWidget {

  List<String> list;
  String hintText = "";
  final Function(String) onClickAction;

   DropdownSpinner(this.list ,this.hintText, this.onClickAction,{super.key});

  @override
  State<DropdownSpinner> createState() => _DropdownSpinnerState();
}

class _DropdownSpinnerState extends State<DropdownSpinner> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
         color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(1.h))),
      width: 13.5.h,
      height: 3.5.h,
      padding: EdgeInsets.only(left: 1.h,right: 1.h),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            isExpanded: true,
        value: dropdownValue,
        //  value: "Karachi",//widget.list.first,
          hint: new Text(widget.hintText,style: TextStyle(color: Colors.black, fontSize: 15.px),),
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
