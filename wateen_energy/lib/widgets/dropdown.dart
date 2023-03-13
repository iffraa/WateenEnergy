import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/utils/colour.dart';

class DropdownSpinner extends StatefulWidget {

  List<String> list;
  String hintText = "";
  final Function(String) onClickAction;
  final bool isWide;

   DropdownSpinner(this.list ,this.hintText, this.onClickAction,this.isWide,{super.key});

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
      width: widget.isWide ? MediaQuery.of(context).size.width * 0.5 : 13.4.h,
      height: 3.7.h,
      padding: EdgeInsets.only(left: 1.h,right: 1.h),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            isExpanded: true,
        value: dropdownValue,
        //  value: "Karachi",//widget.list.first,
          hint: new Text(widget.hintText,style: TextStyle(color: Colors.black, fontSize: 15.px),),
          icon:  Icon(Icons.keyboard_arrow_down_sharp,color: AppColors.darkBlue,),
          iconSize: 2.5.h,
          elevation: 16,
          style:  TextStyle(color: Colors.black,fontSize: 13.px),
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
